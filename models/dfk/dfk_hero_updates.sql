{{
    config(
        materialized='incremental',
        unique_key='log_id',
        incremental_strategy = 'delete+insert',
        tags=['dfk'],
        cluster_by=['block_timestamp']
        ) 
}}

with
events as (
    select
        *
    from {{ ref("logs") }}
    where {{ incremental_load_filter("block_timestamp") }}
        and topics[0] = '0x7be34da84992130f23438d167b22f7f7a246aaaf2d7e9dd3c988ee1672fe40fc'
),
final as (
    select
        block_timestamp,
        block_id,
        log_id,
        java_hextoint(substr(data,3+64+(0*64),64)) as hero_id,
        java_hextoint(substr(data,3+64+(1*64),64)) as summoning_info_summonedTime,
        java_hextoint(substr(data,3+64+(2*64),64)) as summoning_info_nextSummonTime,
        java_hextoint(substr(data,3+64+(3*64),64)) as summoning_info_summonerId,
        java_hextoint(substr(data,3+64+(4*64),64)) as summoning_info_assistantId,
        java_hextoint(substr(data,3+64+(5*64),64)) as summoning_info_summons,
        java_hextoint(substr(data,3+64+(6*64),64)) as summoning_info_maxSummons,
        java_hextoint(substr(data,3+64+(7*64),64))::string as hero_info_statGenes,
        java_hextoint(substr(data,3+64+(8*64),64))::string as hero_info_visualGenes,
        java_hextoint(substr(data,3+64+(9*64),64)) as hero_info_rarity,
        java_hextoint(substr(data,3+64+(10*64),64)) as hero_info_shiny,
        java_hextoint(substr(data,3+64+(11*64),64)) as hero_info_generation,
        java_hextoint(substr(data,3+64+(12*64),64)) as hero_info_firstName,
        java_hextoint(substr(data,3+64+(13*64),64)) as hero_info_lastName,
        java_hextoint(substr(data,3+64+(14*64),64)) as hero_info_shinyStyle,
        java_hextoint(substr(data,3+64+(15*64),64)) as hero_info_class,
        java_hextoint(substr(data,3+64+(16*64),64)) as hero_info_subClass,
        java_hextoint(substr(data,3+64+(17*64),64)) as hero_state_staminaFullAt,
        java_hextoint(substr(data,3+64+(18*64),64)) as hero_state_hpFullAt,
        java_hextoint(substr(data,3+64+(19*64),64)) as hero_state_mpFullAt,
        java_hextoint(substr(data,3+64+(20*64),64)) as hero_state_level,
        java_hextoint(substr(data,3+64+(21*64),64)) as hero_state_xp,
        java_hextoint(substr(data,3+64+(22*64),64)) as hero_state_currentQuest,
        java_hextoint(substr(data,3+64+(23*64),64)) as hero_state_sp,
        java_hextoint(substr(data,3+64+(24*64),64)) as hero_state_status,
        java_hextoint(substr(data,3+64+(25*64),64)) as hero_stats_strength,
        java_hextoint(substr(data,3+64+(26*64),64)) as hero_stats_intelligence,
        java_hextoint(substr(data,3+64+(27*64),64)) as hero_stats_wisdom,
        java_hextoint(substr(data,3+64+(28*64),64)) as hero_stats_luck,
        java_hextoint(substr(data,3+64+(29*64),64)) as hero_stats_agility,
        java_hextoint(substr(data,3+64+(30*64),64)) as hero_stats_vitality,
        java_hextoint(substr(data,3+64+(31*64),64)) as hero_stats_endurance,
        java_hextoint(substr(data,3+64+(32*64),64)) as hero_stats_dexterity,
        java_hextoint(substr(data,3+64+(33*64),64)) as hero_stats_hp,
        java_hextoint(substr(data,3+64+(34*64),64)) as hero_stats_mp,
        java_hextoint(substr(data,3+64+(35*64),64)) as hero_stats_stamina,
        java_hextoint(substr(data,3+64+(36*64),64)) as hero_primary_stat_growth_strength,
        java_hextoint(substr(data,3+64+(37*64),64)) as hero_primary_stat_growth_intelligence,
        java_hextoint(substr(data,3+64+(38*64),64)) as hero_primary_stat_growth_wisdom,
        java_hextoint(substr(data,3+64+(39*64),64)) as hero_primary_stat_growth_luck,
        java_hextoint(substr(data,3+64+(40*64),64)) as hero_primary_stat_growth_agility,
        java_hextoint(substr(data,3+64+(41*64),64)) as hero_primary_stat_growth_vitality,
        java_hextoint(substr(data,3+64+(42*64),64)) as hero_primary_stat_growth_endurance,
        java_hextoint(substr(data,3+64+(43*64),64)) as hero_primary_stat_growth_dexterity,
        java_hextoint(substr(data,3+64+(44*64),64)) as hero_primary_stat_growth_hpSm,
        java_hextoint(substr(data,3+64+(45*64),64)) as hero_primary_stat_growth_hpRg,
        java_hextoint(substr(data,3+64+(46*64),64)) as hero_primary_stat_growth_hpLg,
        java_hextoint(substr(data,3+64+(47*64),64)) as hero_primary_stat_growth_mpSm,
        java_hextoint(substr(data,3+64+(48*64),64)) as hero_primary_stat_growth_mpRg,
        java_hextoint(substr(data,3+64+(49*64),64)) as hero_primary_stat_growth_mpLg,
        java_hextoint(substr(data,3+64+(50*64),64)) as hero_secondary_stat_growth_strength,
        java_hextoint(substr(data,3+64+(51*64),64)) as hero_secondary_stat_growth_intelligence,
        java_hextoint(substr(data,3+64+(52*64),64)) as hero_secondary_stat_growth_wisdom,
        java_hextoint(substr(data,3+64+(53*64),64)) as hero_secondary_stat_growth_luck,
        java_hextoint(substr(data,3+64+(54*64),64)) as hero_secondary_stat_growth_agility,
        java_hextoint(substr(data,3+64+(55*64),64)) as hero_secondary_stat_growth_vitality,
        java_hextoint(substr(data,3+64+(56*64),64)) as hero_secondary_stat_growth_endurance,
        java_hextoint(substr(data,3+64+(57*64),64)) as hero_secondary_stat_growth_dexterity,
        java_hextoint(substr(data,3+64+(58*64),64)) as hero_secondary_stat_growth_hpSm,
        java_hextoint(substr(data,3+64+(59*64),64)) as hero_secondary_stat_growth_hpRg,
        java_hextoint(substr(data,3+64+(60*64),64)) as hero_secondary_stat_growth_hpLg,
        java_hextoint(substr(data,3+64+(61*64),64)) as hero_secondary_stat_growth_mpSm,
        java_hextoint(substr(data,3+64+(62*64),64)) as hero_secondary_stat_growth_mpRg,
        java_hextoint(substr(data,3+64+(63*64),64)) as hero_secondary_stat_growth_mpLg,
        java_hextoint(substr(data,3+64+(64*64),64)) as hero_professions_mining,
        java_hextoint(substr(data,3+64+(65*64),64)) as hero_professions_gardening,
        java_hextoint(substr(data,3+64+(66*64),64)) as hero_professions_foraging,
        java_hextoint(substr(data,3+64+(67*64),64)) as hero_professions_fishing
    from events
)

select * from final
