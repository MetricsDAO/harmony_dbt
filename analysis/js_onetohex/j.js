 const gender = { 1: "male", 3: "female" };
 const background = {
   0: "desert",
   2: "forest",
   4: "plains",
   6: "island",
   8: "swamp",
   10: "mountains",
   12: "city",
   14: "arctic",
 };
 const heroclass = {
   0: "warrior",
   1: "knight",
   2: "thief",
   3: "archer",
   4: "priest",
   5: "wizard",
   6: "monk",
   7: "pirate",
   16: "paladin",
   17: "darkKnight",
   18: "summoner",
   19: "ninja",
   24: "dragoon",
   25: "sage",
   28: "dreadKnight",
 };
 const skinColor = {
   0: "c58135",
   2: "f1ca9e",
   4: "985e1c",
   6: "57340c",
   8: "e6a861",
   10: "7b4a11",
   12: "e5ac91",
   14: "aa5c38",
 };
 const hairColor = {
   0: "ab9159",
   1: "af3853",
   2: "578761",
   3: "068483",
   4: "48321e",
   5: "66489e",
   6: "ca93a7",
   7: "62a7e6",
   16: "d7bc65",
   17: "9b68ab",
   18: "8d6b3a",
   19: "566377",
   24: "880016",
   25: "353132",
   28: "8f9bb3",
 };
 const eyeColor = {
   0: "203997",
   2: "896693",
   4: "bb3f55",
   6: "0d7634",
   8: "8d7136",
   10: "613d8a",
   12: "2494a2",
   14: "a41e12",
 };
 const appendageColor = {
   0: "c5bfa7",
   1: "a88b47",
   2: "58381e",
   3: "566f7d",
   4: "2a386d",
   5: "3f2e40",
   6: "830e18",
   7: "6f3a3c",
   16: "6b173c",
   17: "a0304d",
   18: "78547c",
   19: "352a51",
   24: "c29d35",
   25: "211f1f",
   28: "d7d7d7",
 };
 const backAppendageColor = {
   0: "c5bfa7",
   1: "a88b47",
   2: "58381e",
   3: "566f7d",
   4: "2a386d",
   5: "3f2e40",
   6: "830e18",
   7: "6f3a3c",
   16: "6b173c",
   17: "a0304d",
   18: "78547c",
   19: "352a51",
   24: "c29d35",
   25: "211f1f",
   28: "d7d7d7",
 };
 const hairStyle = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };
 const backAppendage = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };
 const headAppendage = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };
 const subClass = {
   0: "warrior",
   1: "knight",
   2: "thief",
   3: "archer",
   4: "priest",
   5: "wizard",
   6: "monk",
   7: "pirate",
   16: "paladin",
   17: "darkKnight",
   18: "summoner",
   19: "ninja",
   24: "dragoon",
   25: "sage",
   28: "dreadKnight",
 };
 const profession = {
   0: "mining",
   2: "gardening",
   4: "fishing",
   6: "foraging",
 };
 const passive1 = {
   0: "Basic1",
   1: "Basic2",
   2: "Basic3",
   3: "Basic4",
   4: "Basic5",
   5: "Basic6",
   6: "Basic7",
   7: "Basic8",
   16: "Advanced1",
   17: "Advanced2",
   18: "Advanced3",
   19: "Advanced4",
   24: "Elite1",
   25: "Elite2",
   28: "Transcendent1",
 };
 const passive2 = {
   0: "Basic1",
   1: "Basic2",
   2: "Basic3",
   3: "Basic4",
   4: "Basic5",
   5: "Basic6",
   6: "Basic7",
   7: "Basic8",
   16: "Advanced1",
   17: "Advanced2",
   18: "Advanced3",
   19: "Advanced4",
   24: "Elite1",
   25: "Elite2",
   28: "Transcendent1",
 };
 const active1 = {
   0: "Basic1",
   1: "Basic2",
   2: "Basic3",
   3: "Basic4",
   4: "Basic5",
   5: "Basic6",
   6: "Basic7",
   7: "Basic8",
   16: "Advanced1",
   17: "Advanced2",
   18: "Advanced3",
   19: "Advanced4",
   24: "Elite1",
   25: "Elite2",
   28: "Transcendent1",
 };
 const active2 = {
   0: "Basic1",
   1: "Basic2",
   2: "Basic3",
   3: "Basic4",
   4: "Basic5",
   5: "Basic6",
   6: "Basic7",
   7: "Basic8",
   16: "Advanced1",
   17: "Advanced2",
   18: "Advanced3",
   19: "Advanced4",
   24: "Elite1",
   25: "Elite2",
   28: "Transcendent1",
 };
 const statBoost1 = {
   0: "STR",
   2: "AGI",
   4: "INT",
   6: "WIS",
   8: "LCK",
   10: "VIT",
   12: "END",
   14: "DEX",
 };
 const statBoost2 = {
   0: "STR",
   2: "AGI",
   4: "INT",
   6: "WIS",
   8: "LCK",
   10: "VIT",
   12: "END",
   14: "DEX",
 };
 const element = {
   0: "fire",
   2: "water",
   4: "earth",
   6: "wind",
   8: "lightning",
   10: "ice",
   12: "light",
   14: "dark",
 };
 const visualUnknown1 = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };
 const visualUnknown2 = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };
 const statsUnknown1 = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };
 const statsUnknown2 = {
   0: 0,
   1: 1,
   2: 2,
   3: 3,
   4: 4,
   5: 5,
   6: 6,
   7: 7,
   16: 16,
   17: 17,
   18: 18,
   19: 19,
   24: 24,
   25: 25,
   28: 28,
 };

const decodeRecessiveGeneAndNormalize = (statGenesRaw) => {
  const recessiveGenesRaw = decodeRecessiveGenes(statGenesRaw);
  const recessiveGenesNormalized =
    normalizeRecessiveGenes(recessiveGenesRaw);

  return recessiveGenesNormalized;
};

const decodeRecessiveGenesAndNormalize = (heroes) => {
  const rgHeroes = heroes.map((hero) => {
    const recessiveGenesRaw = decodeRecessiveGenes(hero.statGenesRaw);
    const recessiveGenesNormalized =
      normalizeRecessiveGenes(recessiveGenesRaw);

    hero.mainClassGenes = recessiveGenesNormalized.mainClassGenes;
    hero.subClassGenes = recessiveGenesNormalized.subClassGenes;
    hero.professionGenes = recessiveGenesNormalized.professionGenes;
    return hero;
  });

  return rgHeroes;
};

const decodeRecessiveGenes = (statGenes) => {
  const abc = "123456789abcdefghijkmnopqrstuvwx";
  let buf = "";
  const base = 32n;
  let mod = 0;
  let genesBigInt = BigInt(statGenes);
  while (genesBigInt >= base) {
    mod = genesBigInt % base;
    buf += abc[mod];
    genesBigInt = (genesBigInt - mod) / base;
  }
  buf += abc[genesBigInt];
  buf = buf.padEnd(48, "1");
  const result = [];
  for (let i = 0; i < buf.length; i += 1) {
    result[i] = abc.indexOf(buf[i]);
  }
  return result;
};

const normalizeRecessiveGenes = (recessiveGenesRaw) => {
  if (!recessiveGenesRaw?.length) {
    return {};
  }

  // Recessive genes contain 12 groups of 4 genes each.
  const geneGroups = [];
  recessiveGenesRaw.reduce((geneGroup, currentGene, index) => {
    geneGroup.push(currentGene);
    if ((index + 1) % 4 === 0) {
      geneGroups.push(geneGroup);
      return [];
    }
    return geneGroup;
  }, []);

  // Group 10 are the profession genes
  const professionGenes = geneGroups[9].map((gene) => profession[gene]);
  // Group 11 are the subClass genes
  const subClassGenes = geneGroups[10].map((gene) => subClass[gene]);
  // Group 12 are the mainClass genes
  const mainClassGenes = geneGroups[11].map((gene) => heroclass[gene]);

  return {
    mainClassGenes,
    subClassGenes,
    professionGenes,
  };
};

console.log(normalizeRecessiveGenes(decodeRecessiveGenes("0x0000000a631011300022840239c4139ce1288007314e7114210cd1321c262042")))