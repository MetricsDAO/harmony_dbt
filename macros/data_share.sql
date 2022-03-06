{% macro grant_data_share_statements() %}
  {% if target.schema == 'PROD' %}
    GRANT SELECT ON TABLE "HARMONY"."PROD"."BLOCKS" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."LOGS" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."SWAPS" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."TRANSFERS" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."TXS" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."LIQUIDITY_POOLS" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."TOKENS" TO SHARE "HARMONY_MDAO";

    GRANT SELECT ON TABLE "HARMONY"."PROD"."DFK_HERO_UPDATES" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."DFK_QUEST_REWARDS" TO SHARE "HARMONY_MDAO";

    GRANT SELECT ON TABLE "HARMONY"."PROD"."TRANQUIL_DAILY_SUPPLY_BORROW" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."TRANQUIL_MARKETS_TOKENPRICE" TO SHARE "HARMONY_MDAO";
    GRANT SELECT ON TABLE "HARMONY"."PROD"."TRANQUIL_TXS" TO SHARE "HARMONY_MDAO";

    GRANT SELECT ON TABLE "HARMONY"."PROD"."BTC_BRIDGE" TO SHARE "HARMONY_MDAO";
  {% else %}
    select 1; -- hooks will error if they don't have valid SQL in them, this handles that!
  {% endif %}
{% endmacro %}
