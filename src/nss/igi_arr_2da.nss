//==========================================/
void set_2da_range(object client)
//==========================================/
    {
    //2DA rows that will be read
    //range: [lower bound 31:16][upper bound 15:0]
    //invalid rows may be included - they are skipped during read.
    SetLocalInt(client, "IPRP_ABILITIES_0", 5);
    SetLocalInt(client, "IPRP_ACMODTYPE_0", 4);
    SetLocalInt(client, "IPRP_ALIGNGRP_0", 5);
    SetLocalInt(client, "IPRP_ALIGNMENT_0", 8);
    SetLocalInt(client, "IPRP_AMMOCOST_0", 15);
    SetLocalInt(client, "IPRP_AMMOTYPE_0", 2);
    SetLocalInt(client, "IPRP_AMOUNT_0", 4);
    SetLocalInt(client, "IPRP_ARCSPELL_0", 19);
    //SetLocalInt(client, "IPRP_BASE1_0", 0);
    SetLocalInt(client, "IPRP_BLADECOST_0", 5);
    SetLocalInt(client, "IPRP_BONUSCOST_0", 12);
    SetLocalInt(client, "IPRP_CHARGECOST_0", 13);
    SetLocalInt(client, "IPRP_COLOR_0", 6);
    SetLocalInt(client, "IPRP_COMBATDAM_0", 2);
    SetLocalInt(client, "IPRP_COSTTABLE_0", 30); //1.69
    SetLocalInt(client, "IPRP_DAMAGECOST_0", 30);

    SetLocalInt(client, "IPRP_DAMAGETYPE_0", 13);
    SetLocalInt(client, "IPRP_DAMVULCOST_0", 7);

    SetLocalInt(client, "IPRP_FEATS_0", 62); //1.69

    SetLocalInt(client, "IPRP_IMMUNCOST_0", 7);
    SetLocalInt(client, "IPRP_IMMUNITY_0", 9);
    SetLocalInt(client, "IPRP_KITCOST_0", 50);
    SetLocalInt(client, "IPRP_LIGHTCOST_0", 4);
    SetLocalInt(client, "IPRP_MELEECOST_0", 20);
    SetLocalInt(client, "IPRP_MONSTCOST_0", 57);
    SetLocalInt(client, "IPRP_MONSTERHIT_0", 9);
    SetLocalInt(client, "IPRP_NEG10COST_0", 50); //1.69
    SetLocalInt(client, "IPRP_NEG5COST_0", 5);
    SetLocalInt(client, "IPRP_ONHIT_0", 25);
    SetLocalInt(client, "IPRP_ONHITCOST_0", 6);

    SetLocalInt(client, "IPRP_ONHITDUR_0", 4);

    SetLocalInt(client, "IPRP_ONHITSPELL_0", 140); //1.69

    SetLocalInt(client, "IPRP_PARAMTABLE_0", 11);
    SetLocalInt(client, "IPRP_POISON_0", 5);
    SetLocalInt(client, "IPRP_PROTECTION_0", 19);
    SetLocalInt(client, "IPRP_REDCOST_0", 5);

    SetLocalInt(client, "IPRP_RESISTCOST_0", 10);

    SetLocalInt(client, "IPRP_SAVEELEMENT_0", 21);
    SetLocalInt(client, "IPRP_SAVINGTHROW_0", 3);
    SetLocalInt(client, "IPRP_SKILLCOST_0", 50);
    //SetLocalInt(client, "IPRP_SLOTSCOST_0", 0);
    SetLocalInt(client, "IPRP_SOAKCOST_0", 10);
    SetLocalInt(client, "IPRP_SPELLCOST_0", 240); //1.69
    SetLocalInt(client, "IPRP_SPELLCSTR_0", 39);
    SetLocalInt(client, "IPRP_SPELLLVCOST_0", 9);
    SetLocalInt(client, "IPRP_SPELLLVLIMM_0", 9);

    SetLocalInt(client, "IPRP_SPELLS_0", 500);
    SetLocalInt(client, "IPRP_SPELLS_1", 511 << BITLEN_2DA_RANGE | 539); //1.69

    SetLocalInt(client, "IPRP_SPELLSHL_0", 7);
    SetLocalInt(client, "IPRP_SRCOST_0", 11);

    //SetLocalInt(client, "IPRP_STAMINACOAT_0", 0);
    //SetLocalInt(client, "IPRP_TERRAINTYPE_0", 0);
    SetLocalInt(client, "IPRP_TRAPCOST_0", 11); //1.69
    SetLocalInt(client, "IPRP_TRAPS_0", 4);
    SetLocalInt(client, "IPRP_VISUALFX_0", 6);
    SetLocalInt(client, "IPRP_WALK_0", 1);
    SetLocalInt(client, "IPRP_WEIGHTCOST_0", 6);
    SetLocalInt(client, "IPRP_WEIGHTINC_0", 5);

    SetLocalInt(client, "Classes_0", 41); //1.69

    SetLocalInt(client, "racialtypes_0", 29);
    SetLocalInt(client, "racialtypes_1", 50 << BITLEN_2DA_RANGE | 53); //cep2.2

    SetLocalInt(client, "skills_0", 27); //1.69
    SetLocalInt(client, "Skills_0", 27); //1.69

    SetLocalInt(client, "disease_0", 16);
    SetLocalInt(client, "poison_0", 44);
    SetLocalInt(client, "gender_0", 4);

    //--------------------------------------/
    //1.69 add
    SetLocalInt(client, "IPRP_ADDCOST_0", 1);
    SetLocalInt(client, "IPRP_ADDITIONAL_0", 1);
    SetLocalInt(client, "IPRP_MATCOST_0", 77);
    SetLocalInt(client, "IPRP_MATERIAL_0", 77);
    SetLocalInt(client, "IPRP_QUALCOST_0", 15);
    SetLocalInt(client, "IPRP_QUALITY_0", 15);

    //--------------------------------------/
    SetLocalInt(client, "itempropdef_0", 11); //this is broken up based on TMI instruction limit
    SetLocalInt(client, "itempropdef_1", 12 << BITLEN_2DA_RANGE | 14);
    SetLocalInt(client, "itempropdef_2", 15 << BITLEN_2DA_RANGE | 15);
    SetLocalInt(client, "itempropdef_3", 16 << BITLEN_2DA_RANGE | 30);
    SetLocalInt(client, "itempropdef_4", 31 << BITLEN_2DA_RANGE | 40);
    SetLocalInt(client, "itempropdef_5", 41 << BITLEN_2DA_RANGE | 50);
    SetLocalInt(client, "itempropdef_6", 51 << BITLEN_2DA_RANGE | 60);
    SetLocalInt(client, "itempropdef_7", 61 << BITLEN_2DA_RANGE | 70);
    SetLocalInt(client, "itempropdef_8", 71 << BITLEN_2DA_RANGE | 87); //1.69
    SetLocalInt(client, "itempropdef_9", 150 << BITLEN_2DA_RANGE | 156); //cep2.2

    SetLocalInt(client, "itemprops_0", 87); //1.69
    SetLocalInt(client, "itemprops_1", 150 << BITLEN_2DA_RANGE | 156); //cep2.2

    SetLocalInt(client, "itemvalue_0", 59);
    }
