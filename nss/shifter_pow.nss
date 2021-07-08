#include "shifter_lib"

void LoadFormPowers(object oFormTarget, object oFormDataItem)
{
    string FormResRef = GetLocalString(oFormDataItem,"CREATURE_RESREF");
    string FormName = GetLocalString(oFormDataItem,"CREATURE_NAME");

    switch(GetLocalInt(oFormDataItem,"CREATURE_RACE"))
    {
        case RACIAL_TYPE_ABERRATION:
            if (FindSubString(FormResRef,"nw_battdevour")!=-1)
            {
                CreateItemOnObject("it_shifter_po040",oFormTarget,1,MimicPowerTag);
            }
            else
            if (FindSubString(FormResRef,"x2_beholder001")!=-1)
            {
                CreateItemOnObject("it_shifter_po019",oFormTarget,1,MimicPowerTag);
                // ^ you may want to disable this one or allow at epic shifter only
                CreateItemOnObject("it_shifter_po002",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po003",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po004",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po005",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po006",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po007",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po008",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po009",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po010",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po011",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po012",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_drider001")!=-1)
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po021",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_ettercap")!=-1)
            {
                CreateItemOnObject("it_shifter_po113",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po021",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_beholder002")!=-1)
            {
                CreateItemOnObject("it_shifter_po037",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po038",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po039",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_devour")!=-1)
            {
                CreateItemOnObject("it_shifter_po042",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_umberhulk")!=-1)
            {
                CreateItemOnObject("it_shifter_po041",oFormTarget,1,MimicPowerTag);
            }
            else if ((FindSubString(FormResRef,"x2_mindflayer001")!=-1)
                   ||(FindSubString(FormResRef,"x2_mindflayer002")!=-1))
            {
                CreateItemOnObject("it_shifter_po013",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po014",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po015",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po016",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po137",oFormTarget,1,MimicPowerTag);
                // ^ Suck Brain
             }
            else if (FindSubString(FormResRef,"nw_willowisp")!=-1)
            {
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_ANIMAL:
            if (FindSubString(FormResRef,"nw_badger")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_beardire")!=-1)
            {
                CreateItemOnObject("it_shifter_po136",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_boardire")!=-1)
            {
                CreateItemOnObject("it_shifter_po087",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_sharkmako")!=-1)
            {
                CreateItemOnObject("it_shifter_po087",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_CONSTRUCT:
            if (FindSubString(FormResRef,"nw_golbone")!=-1)
            {
                CreateItemOnObject("it_shifter_po056",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_golclay")!=-1)
            {
                CreateItemOnObject("it_shifter_po057",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_goldmflesh001")!=-1)
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po059",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po089",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_golflesh")!=-1)
            {
                CreateItemOnObject("it_shifter_po060",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_minogon")!=-1)
            {
                CreateItemOnObject("it_shifter_po058",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_golem001")!=-1)
            {
                CreateItemOnObject("it_shifter_po140",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_goliron")!=-1)
            {
                CreateItemOnObject("it_shifter_po022",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_shguard")!=-1)
            {
                CreateItemOnObject("it_shifter_po063",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po064",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po065",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_golstone")!=-1)
            {
                CreateItemOnObject("it_shifter_po061",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_DRAGON:
            if (FindSubString(FormResRef,"x0_dragon_faerie")!=-1)
            {
                CreateItemOnObject("it_shifter_po070",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_dragonpris001")!=-1)
            {
                CreateItemOnObject("it_shifter_po071",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po072",oFormTarget,1,MimicPowerTag);
            }
          //else if ((FindSubString(FormResRef,"Adult")!=-1)
          //  ||(FindSubString(FormResRef,"Old")!=-1)
          //  ||(FindSubString(FormResRef,"Ancient")!=-1))
            {
          //    CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
          //    copied to each Dragonshape
                if (FindSubString(FormResRef,"x2_dragonshad001")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po073",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po074",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po075",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgblack001")!=-1
                       ||FindSubString(FormResRef,"nw_drgblack002")!=-1
                       ||FindSubString(FormResRef,"nw_drgblack003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po076",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgblue001")!=-1
                       ||FindSubString(FormResRef,"nw_drgblue002")!=-1
                       ||FindSubString(FormResRef,"nw_drgblue003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po081",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgbrass001")!=-1
                       ||FindSubString(FormResRef,"nw_drgbrass002")!=-1
                       ||FindSubString(FormResRef,"nw_drgbrass003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po079",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po083",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgbrnz001")!=-1
                       ||FindSubString(FormResRef,"nw_drgbrnz002")!=-1
                       ||FindSubString(FormResRef,"nw_drgbrnz003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po081",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po080",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgcopp001")!=-1
                       ||FindSubString(FormResRef,"nw_drgcopp002")!=-1
                       ||FindSubString(FormResRef,"nw_drgcopp003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po076",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po080",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drggold001")!=-1
                       ||FindSubString(FormResRef,"nw_drggold002")!=-1
                       ||FindSubString(FormResRef,"nw_drggold003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po079",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po084",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drggreen001")!=-1
                       ||FindSubString(FormResRef,"nw_drggreen002")!=-1
                       ||FindSubString(FormResRef,"nw_drggreen003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po076",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgred001")!=-1
                       ||FindSubString(FormResRef,"nw_drgred002")!=-1
                       ||FindSubString(FormResRef,"nw_drgred003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po079",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgsilv001")!=-1
                       ||FindSubString(FormResRef,"nw_drgsilv002")!=-1
                       ||FindSubString(FormResRef,"nw_drgsilv003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po077",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po082",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"nw_drgwhite001")!=-1
                       ||FindSubString(FormResRef,"nw_drgwhite002")!=-1
                       ||FindSubString(FormResRef,"nw_drgwhite003")!=-1)
                {
                  CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po077",oFormTarget,1,MimicPowerTag);
                }
            }
          //else if (FindSubString(FormResRef,"Wyrmling")!=-1)
            {
                if (FindSubString(FormResRef,"x0_wyrmling_blk")!=-1)
                {
                    CreateItemOnObject("it_shifter_po131",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_blu")!=-1)
                {
                    CreateItemOnObject("it_shifter_po142",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_brs")!=-1)
                {
                    CreateItemOnObject("it_shifter_po138",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po083",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_brz")!=-1)
                {
                    CreateItemOnObject("it_shifter_po141",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po142",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_cop")!=-1)
                {
                    CreateItemOnObject("it_shifter_po131",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po141",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_gld")!=-1)
                {
                    CreateItemOnObject("it_shifter_po138",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po084",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_grn")!=-1)
                {
                    CreateItemOnObject("it_shifter_po131",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_red")!=-1)
                {
                    CreateItemOnObject("it_shifter_po138",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_sil")!=-1)
                {
                    CreateItemOnObject("it_shifter_po108",oFormTarget,1,MimicPowerTag);
                    CreateItemOnObject("it_shifter_po082",oFormTarget,1,MimicPowerTag);
                }
                else if (FindSubString(FormResRef,"x0_wyrmling_wht")!=-1)
                {
                    CreateItemOnObject("it_shifter_po108",oFormTarget,1,MimicPowerTag);
                }
            }
        break;

        case RACIAL_TYPE_ELEMENTAL:
            if (FindSubString(FormResRef,"nw_air")!=-1
              ||FindSubString(FormResRef,"nw_airhuge")!=-1
              ||FindSubString(FormResRef,"nw_airgreat")!=-1
              ||FindSubString(FormResRef,"nw_airelder")!=-1)
            {
                CreateItemOnObject("it_shifter_po067",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_water")!=-1
                   ||FindSubString(FormResRef,"nw_waterhuge")!=-1
                   ||FindSubString(FormResRef,"nw_watergreat")!=-1
                   ||FindSubString(FormResRef,"nw_watelder")!=-1)
            {
                CreateItemOnObject("it_shifter_po068",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_ELF:
            if (FindSubString(FormName,"Drow")!=-1)
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_FEY:
            if (FindSubString(FormResRef,"nw_pixie")!=-1)
            {
                CreateItemOnObject("it_shifter_po027",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po034",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po035",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_dryad")!=-1)
            {
                CreateItemOnObject("it_shifter_po032",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po026",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_grig")!=-1)
            {
                CreateItemOnObject("it_shifter_po034",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_nixie")!=-1)
            {
                CreateItemOnObject("it_shifter_po026",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_nymph")!=-1)
            {
                //CreateItemOnObject("it_shifter_po031",oFormTarget,1,MimicPowerTag);
                // death aura is fun, but unbalancing, blindness used from pnp
                CreateItemOnObject("it_shifter_po033",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po051",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_GIANT:
            if ((FindSubString(FormResRef,"nw_gnthill")!=-1)
              ||(FindSubString(FormResRef,"nw_gntmount")!=-1))
            {
                CreateItemOnObject("it_shifter_po055",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_ogrechief01")!=-1
                   ||FindSubString(FormResRef,"nw_ogrechief02")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
            else if ((FindSubString(FormResRef,"nw_ogremage01")!=-1)
                   ||(FindSubString(FormResRef,"nw_ogremage02")!=-1))
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po026",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po096",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po097",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_trollchief")!=-1)
            {
                CreateItemOnObject("it_shifter_po095",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_HALFORC:
            if (FindSubString(FormResRef,"nw_bandit006")!=-1)
            {
                CreateItemOnObject("it_shifter_po095",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_HUMANOID_GOBLINOID:
            if (FindSubString(FormResRef,"nw_bugchiefa")!=-1
              ||FindSubString(FormResRef,"nw_bugchiefb")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_gobchiefa")!=-1
                   ||FindSubString(FormResRef,"nw_gobchiefb")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_HUMANOID_MONSTROUS:
            if (FindSubString(FormResRef,"x2_harpy001")!=-1)
            {
                CreateItemOnObject("it_shifter_po119",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_medusa")!=-1)
            {
                CreateItemOnObject("it_shifter_po090",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_minchief")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_seahag")!=-1)
            {
                CreateItemOnObject("it_shifter_po093",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po094",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_HUMANOID_ORC:
            if (FindSubString(FormResRef,"nw_orcchiefa")!=-1
              ||FindSubString(FormResRef,"nw_orcchiefb")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_HUMANOID_REPTILIAN:
            if (FindSubString(FormResRef,"nw_kobold003")!=-1)
            {
                CreateItemOnObject("it_shifter_po044",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_sahuaginldr")!=-1)
            {
                CreateItemOnObject("it_shifter_po088",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_trog001")!=-1
                   ||FindSubString(FormResRef,"nw_trog002")!=-1
                   ||FindSubString(FormResRef,"nw_trog003")!=-1)
            {
                CreateItemOnObject("it_shifter_po049",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_yuan_ti001")!=-1
                   ||FindSubString(FormResRef,"nw_yuan_ti002")!=-1
                   ||FindSubString(FormResRef,"nw_yuan_ti003")!=-1)
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po026",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po034",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po047",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po048",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_MAGICAL_BEAST:
            if (FindSubString(FormResRef,"x0_sphinx")!=-1)
            {
                CreateItemOnObject("it_shifter_po056",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po133",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po134",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_basilisk")!=-1)
            {
                CreateItemOnObject("it_shifter_po090",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_cockatrice")!=-1)
            {
                CreateItemOnObject("it_shifter_po092",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_gorgon")!=-1)
            {
                CreateItemOnObject("it_shifter_po091",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_gynosphinx")!=-1)
            {
                CreateItemOnObject("it_shifter_po027",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po054",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po112",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_krenshar")!=-1)
            {
                CreateItemOnObject("it_shifter_po120",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_manticore")!=-1)
            {
                CreateItemOnObject("it_shifter_po001",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_spidphase")!=-1)
            {
                CreateItemOnObject("it_shifter_po021",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po030",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_wolfwint")!=-1)
            {
                CreateItemOnObject("it_shifter_po036",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_OUTSIDER:
            //Planar, Celestial
            if (FindSubString(FormResRef,"nw_chound01")!=-1)
            {
                CreateItemOnObject("it_shifter_po115",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po117",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_clantern")!=-1)
            {
                CreateItemOnObject("it_shifter_po117",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po118",oFormTarget,1,MimicPowerTag);
            }

            //Planar, Fiendish
            else if (FindSubString(FormResRef,"nw_demon")!=-1)
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po024",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po100",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po103",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_spiderdemo001")!=-1)
            {
                CreateItemOnObject("it_shifter_po114",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po116",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po021",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_erinyes")!=-1)
            {
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po050",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po052",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po053",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po054",oFormTarget,1,MimicPowerTag);
            }
            else if ((FindSubString(FormResRef,"Fenhound")!=-1)
                   ||(FindSubString(FormResRef,"nw_shmastif")!=-1))
            {
                CreateItemOnObject("it_shifter_po056",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_hellhound")!=-1)
            {
                CreateItemOnObject("it_shifter_po023",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_beastxvim")!=-1)
            {
                CreateItemOnObject("it_shifter_po023",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po056",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_devil001")!=-1
                   ||FindSubString(FormResRef,"x2_pitfiend001")!=-1)
            {
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po024",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po025",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po026",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po027",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po028",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_rakshasa")!=-1)
            {
                CreateItemOnObject("it_shifter_po026",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po027",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po063",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_dmsucubus")!=-1)
            {
                CreateItemOnObject("it_shifter_po030",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po050",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_dmvrock")!=-1)
            {
                CreateItemOnObject("it_shifter_po018",oFormTarget,1,MimicPowerTag);
            }

            //Planar, Imp
            else if ((FindSubString(FormResRef,"nw_imp")!=-1)
                   ||(FindSubString(FormResRef,"nw_dmquasit")!=-1))
            {
                CreateItemOnObject("it_shifter_po043",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po063",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepair")!=-1)
            {
                CreateItemOnObject("it_shifter_po064",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepfire")!=-1)
            {
                CreateItemOnObject("it_shifter_po123",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po129",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepice")!=-1)
            {
                CreateItemOnObject("it_shifter_po036",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po129",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepmagma")!=-1)
            {
                CreateItemOnObject("it_shifter_po123",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepooze")!=-1)
            {
                CreateItemOnObject("it_shifter_po064",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po121",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po128",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepsalt")!=-1)
            {
                CreateItemOnObject("it_shifter_po125",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepsteam")!=-1)
            {
                CreateItemOnObject("it_shifter_po126",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mepwater")!=-1)
            {
                CreateItemOnObject("it_shifter_po064",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po121",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po128",oFormTarget,1,MimicPowerTag);
            }

            //Planar, Other
            else if (FindSubString(FormResRef,"x0_form_myrmarch")!=-1)
            {
                CreateItemOnObject("it_shifter_po050",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po053",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po112",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_form_queen")!=-1)
            {
                CreateItemOnObject("it_shifter_po050",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po053",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po112",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po113",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_form_taskmast")!=-1)
            {
                CreateItemOnObject("it_shifter_po042",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x0_form_worker")!=-1)
            {
                CreateItemOnObject("it_shifter_po110",oFormTarget,1,MimicPowerTag);
            }

            //Planar, Slaad
            else if (FindSubString(FormResRef,"nw_slaadred")!=-1)
            {
                CreateItemOnObject("it_shifter_po058",oFormTarget,1,MimicPowerTag);
            }
            else if ((FindSubString(FormResRef,"x2_slaadblack001")!=-1)
                   ||(FindSubString(FormResRef,"x2_slaadwhite001")!=-1))
            {
                CreateItemOnObject("it_shifter_po109",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_SHAPECHANGER:
            if (FindSubString(FormResRef,"nw_aranea")!=-1)
            {
                CreateItemOnObject("it_shifter_po113",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_UNDEAD:
            if (FindSubString(FormResRef,"x2_mindflayer003")!=-1)
            {
                CreateItemOnObject("it_shifter_po013",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po014",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po015",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po016",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_bodak")!=-1)
            {
                CreateItemOnObject("it_shifter_po045",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_doomkght")!=-1)
            {
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po027",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po054",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po139",oFormTarget,1,MimicPowerTag);
                // ^ Bolster Undead            }
            }
            else if (FindSubString(FormResRef,"nw_ghast")!=-1)
            {
                CreateItemOnObject("it_shifter_po086",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_ghoullord")!=-1)
            {
                CreateItemOnObject("it_shifter_po057",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po098",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"x2_demilich001")!=-1)
            {
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po100",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po106",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po107",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po139",oFormTarget,1,MimicPowerTag);
                // ^ Bolster Undead            }
            }
            else if (FindSubString(FormResRef,"x2_dracolich001")!=-1)
            {
                CreateItemOnObject("it_shifter_po069",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po079",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po104",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po105",oFormTarget,1,MimicPowerTag);
            }
            else if ((FindSubString(FormResRef,"nw_lich002")!=-1)||(FindSubString(FormResRef,"Lich")!=-1))
            {
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_mummy")!=-1)
            {
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_revenant001")!=-1)
            {
                CreateItemOnObject("it_shifter_po059",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_shfiend")!=-1)
            {
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_skeldevour")!=-1)
            {
                CreateItemOnObject("it_shifter_po017",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po020",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po099",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po101",oFormTarget,1,MimicPowerTag);
                CreateItemOnObject("it_shifter_po102",oFormTarget,1,MimicPowerTag);
            }
            else if ((FindSubString(FormResRef,"nw_spectre")!=-1)
                   ||(FindSubString(FormResRef,"nw_wraith")!=-1))
            {
                CreateItemOnObject("it_shifter_po098",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_zombtyrant")!=-1)
            {
                CreateItemOnObject("it_shifter_po086",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_vampire")!=-1)
            {
                CreateItemOnObject("it_shifter_po046",oFormTarget,1,MimicPowerTag);
            }
        break;

        case RACIAL_TYPE_VERMIN:
            if (FindSubString(FormResRef,"nw_btlbomb")!=-1)
            {
                CreateItemOnObject("it_shifter_po121",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_spidgiant")!=-1)
            {
                CreateItemOnObject("it_shifter_po021",oFormTarget,1,MimicPowerTag);
            }
            else if (FindSubString(FormResRef,"nw_btlfire02")!=-1)
            {
                CreateItemOnObject("it_shifter_po122",oFormTarget,1,MimicPowerTag);
            }
        break;
    }
}

//void main() {}

