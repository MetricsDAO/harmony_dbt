

var CHARSET = "qpzry9x8gf2tvdw0s3jn54khce6mua7l";
var GENERATOR = [0x3b6a57b2, 0x26508e6d, 0x1ea119fa, 0x3d4233dd, 0x2a1462b3];

const encodings = {
  BECH32: "bech32",
  BECH32M: "bech32m",
};

function getEncodingConst (enc) {
  if (enc == encodings.BECH32) {
    return 1;
  } else if (enc == encodings.BECH32M) {
    return 0x2bc830a3;
  } else {
    return "getEncodingConst 1";
  }
}

function polymod (values) {
  var chk = 1;
  for (var p = 0; p < values.length; ++p) {
    var top = chk >> 25;
    chk = (chk & 0x1ffffff) << 5 ^ values[p];
    for (var i = 0; i < 5; ++i) {
      if ((top >> i) & 1) {
        chk ^= GENERATOR[i];
      }
    }
  }
  return chk;
}

function hrpExpand (hrp) {
  var ret = [];
  var p;
  for (p = 0; p < hrp.length; ++p) {
    ret.push(hrp.charCodeAt(p) >> 5);
  }
  ret.push(0);
  for (p = 0; p < hrp.length; ++p) {
    ret.push(hrp.charCodeAt(p) & 31);
  }
  return ret;
}

function verifyChecksum (hrp, data, enc) {
  return polymod(hrpExpand(hrp).concat(data)) === getEncodingConst(enc);
}

function createChecksum (hrp, data, enc) {
  var values = hrpExpand(hrp).concat(data).concat([0, 0, 0, 0, 0, 0]);
  var mod = polymod(values) ^ getEncodingConst(enc);
  var ret = [];
  for (var p = 0; p < 6; ++p) {
    ret.push((mod >> 5 * (5 - p)) & 31);
  }
  return ret;
}

function encode (hrp, data, enc) {
  var combined = data.concat(createChecksum(hrp, data, enc));
  var ret = hrp + "1";
  for (var p = 0; p < combined.length; ++p) {
    ret += CHARSET.charAt(combined[p]);
  }
  return ret;
}

function decode (bechString, enc) {
  var p;
  var has_lower = false;
  var has_upper = false;
  for (p = 0; p < bechString.length; ++p) {
    if (bechString.charCodeAt(p) < 33 || bechString.charCodeAt(p) > 126) {
      return "decode " + bechString.charCodeAt(p);
    }
    if (bechString.charCodeAt(p) >= 97 && bechString.charCodeAt(p) <= 122) {
        has_lower = true;
    }
    if (bechString.charCodeAt(p) >= 65 && bechString.charCodeAt(p) <= 90) {
        has_upper = true;
    }
  }
  if (has_lower && has_upper) {
    return "decode 2";
  }
  bechString = bechString.toLowerCase();
  var pos = bechString.lastIndexOf("1");
  if (pos < 1 || pos + 7 > bechString.length || bechString.length > 90) {
    return "decode 3";
  }
  var hrp = bechString.substring(0, pos);
  var data = [];
  for (p = pos + 1; p < bechString.length; ++p) {
    var d = CHARSET.indexOf(bechString.charAt(p));
    if (d === -1) {
        return "decode 4";
    }
    data.push(d);
  }
  if (!verifyChecksum(hrp, data, enc)) {
    return "decode 5";
  }
  return {hrp: hrp, data: data.slice(0, data.length - 6)};
}

function convertbits (data, frombits, tobits, pad) {
  var acc = 0;
  var bits = 0;
  var ret = [];
  var maxv = (1 << tobits) - 1;
  for (var p = 0; p < data.length; ++p) {
    var value = data[p];
    if (value < 0 || (value >> frombits) !== 0) {
        return "convertbits 1";
    }
    acc = (acc << frombits) | value;
    bits += frombits;
    while (bits >= tobits) {
      bits -= tobits;
      ret.push((acc >> bits) & maxv);
    }
  }
  if (pad) {
    if (bits > 0) {
      ret.push((acc << (tobits - bits)) & maxv);
    }
  } else if (bits >= frombits /*|| ((acc << (tobits - bits)) & maxv)*/) {
    return "convertbits 2:" + (bits >= frombits) +":"+ ((acc << (tobits - bits)) & maxv)
  }
  return ret;
}

function ndecode (hrp, addr) {
  var bech32m = false;
  var dec = decode(addr, encodings.BECH32);
  if (dec === null) {
    dec = decode(addr, encodings.BECH32M);
    bech32m = true;
  }
  console.log("m?", bech32m);
  if (dec === null /*|| dec.hrp !== hrp*/ || dec.data.length < 1 /*|| dec.data[0] > 16*/) {
    return "ndecode 1:" + (dec === null) +":"+ (dec.hrp !== hrp) +":"+ (dec.data.length < 1) +":"+ (dec.data[0] > 16)
  }
  var res = convertbits(dec.data.slice(1), 5, 8, false);
  if (res === null || res.length < 2 || res.length > 40) {
    return "ndecode 2";
  }
  if (dec.data[0] === 0 && res.length !== 20 && res.length !== 32) {
    return "ndecode 3";
  }
  if (dec.data[0] === 0 && bech32m) {
    return "ndecode 4";
  }
  /*
  if (dec.data[0] !== 0 && !bech32m) {
    return "ndecode 5";
  }
  */
  return {version: dec.data[0], program: res};
}



var result = ndecode("one1","one164pcrdnymhvts3r58zz0tthrlfed33gz0xnndc")
var word = "0x"
result.program.forEach(e => {
    word += e.toString(16)
});
console.log(word);
console.log("0xd54381b664ddd8b844743884f5aee3fa72d8c502")