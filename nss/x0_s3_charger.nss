//:://////////////////////////////////////////////
//:: x0_s3_charger
//:: (magic electrifier)
//:://////////////////////////////////////////////
/*
    Generic recharging item.

    Destroyed items contribute their value in gp to the stored energy.

    Energy is usually converted to charges at a 1000:1 rate, but this can be
    altered via a local float named ELECTRIFIER_CHARGE_SCALE on the item to be
    charged (the local float, if positive, multiplies the "1000" part, so bigger
    numbers means harder to charge; negative values should be avoided as they are
    reserved for future functionality).
    I'll also support this local float on the electrifier itself, which opens
    the possibility of some electrifiers being more efficient than others. Again,
    large numbers will mean harder to generate a charge.

    The maximum charges an item can have after charging can be set via a local
    integer named ELECTRIFIER_CHARGE_MAX on the item to be charged. Since there
    is no way to distinguish a zero value from an unset value, use -1 to specify
    an item that cannot be charged with the electrifier. (Currently other
    negative values will have the same result, but that may be subject to change.)
*/
//:://////////////////////////////////////////////
//:: Based on the original script by: Brent Knowles
//:: Overhauled by: The Krit
//:://////////////////////////////////////////////


#include "colors_inc"


// Names of local variables used.
const string LV_SCALE  = "ELECTRIFIER_CHARGE_SCALE";
const string LV_MAX    = "ELECTRIFIER_CHARGE_MAX";
const string LV_ENERGY = "X0_L_CHARGES_ELECTRIFIER"; // Same name as used by the BioWare script.


// Converts the stored energy to charges.
int GetCharges(object oData, float fScale=0.0);

// Like FloatingTextStrRefOnCreature(), but colors the text based on oData's energy.
void FloatingEnergyStrRefOnCreature(int nStrRefToDisplay, object oCreatureToFloatAbove, object oData, int bBroadcastToFaction=TRUE);

void main()
{
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    object oData = GetSpellCastItem();
    // This should only ever be cast from an item, but it basically takes just
    // a one-liner to support casting from memory.
    if ( oData == OBJECT_INVALID )
        oData = oCaster;

    // Sanity check
    if ( oTarget == oData )
    {
        FloatingTextStrRefOnCreature(83384, oCaster, FALSE); // "* Failure - Invalid Target *"
        return;
    }

    // We only support item targets.
    if ( GetObjectType(oTarget) != OBJECT_TYPE_ITEM )
    {
        FloatingTextStrRefOnCreature(83384, oCaster, FALSE); // "* Failure - Invalid Target *"
        return;
    }

    // Charge or decharge?
    switch ( GetSpellId() )
    {
        case 509: // would be SPELL_CHARGER, but that constant is incorrectly defined.
        {
            int nCharges    = GetItemCharges(oTarget);
            int nNewCharges = GetCharges(oData, GetLocalFloat(oTarget, LV_SCALE));
            int nMaxCharges = GetLocalInt(oTarget, LV_MAX);
            if ( nMaxCharges == 0 )
                nMaxCharges = 50; // Max allowed by the game.

            // Can only charge items that use charges.
            if ( nCharges <= 0 )
                FloatingTextStrRefOnCreature(83384, oCaster, FALSE); // "* Failure - Invalid Target *"

            // Cannot charge without energy.
            else if ( nNewCharges < 1 )
                FloatingTextStrRefOnCreature(40056, oCaster, FALSE); // "There is no charge. You must use the destroy ability on other items to charge this item."

            // Cannot charge items already at maximum.
            else if ( nCharges >= nMaxCharges )
                FloatingTextStringOnCreature("Item already charged", oCaster, FALSE); // No StringRef for this. Sorry.

            else
            {
                // Adjust for the maximum charge. (Excess is lost.)
                if ( nCharges + nNewCharges > nMaxCharges )
                    nNewCharges = nMaxCharges - nCharges;

                // Charge the target.
                SetItemCharges(oTarget, nCharges + nNewCharges);
                // Empty the electrifier.
                SetLocalInt(oData, LV_ENERGY, 0);

                // Feedback.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE), oCaster);
                FloatingTextStrRefOnCreature(40055, oCaster, FALSE); // "Item charged"
            }
        }
        break;

        case SPELL_DECHARGER:
        {
            // Block some items from destruction.
            if ( GetPlotFlag(oTarget)  ||  GetItemCursedFlag(oTarget) )
                FloatingTextStrRefOnCreature(83384, oCaster, FALSE); // "* Failure - Invalid Target *"

            // Safety check
            if ( GetItemPossessor(oTarget) != oCaster )
                FloatingTextStrRefOnCreature(83384, oCaster, FALSE); // "* Failure - Invalid Target *"

            else
            {
                // Update the stored energy.
                SetLocalInt(oData, LV_ENERGY,
                    GetLocalInt(oData, LV_ENERGY) + GetGoldPieceValue(oTarget));

                DestroyObject(oTarget);

                // Feedback.
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), oCaster);
                FloatingEnergyStrRefOnCreature(40057, oCaster, oData, FALSE); // "Item destroyed. The electrifier has been charged."
            }
        }
    }
}


// -----------------------------------------------------------------------------


// Converts the stored energy to charges.
int GetCharges(object oData, float fScale=0.0)
{
    float fMyScale = GetLocalFloat(oData, LV_SCALE);
    float fEnergy  = IntToFloat(GetLocalInt(oData, LV_ENERGY));

    // Scale it?
    if ( fScale > 0.0 )
        fEnergy /= fScale;
    if ( fMyScale > 0.0 )
        fEnergy /= fMyScale;

    // Convert to charges and return.
    return FloatToInt(fEnergy) / 1000;
}


// Like FloatingTextStrRefOnCreature(), but colors the text based on oData's energy.
void FloatingEnergyStrRefOnCreature(int nStrRefToDisplay, object oCreatureToFloatAbove, object oData, int bBroadcastToFaction=TRUE)
{
    // Convert energy to color codes. (Going with white -> yellow -> red.)
    int nEnergy = GetCharges(oData, 0.1); // The 0.1 causes 50 charges to become 500.
    int nGreen  = nEnergy <= 255 ? 255 : (nEnergy >= 510 ? 0 : 510 - nEnergy);
    int nBlue   =                         nEnergy >= 255 ? 0 : 255 - nEnergy;

    // Get the message and add colors.
    string sText = ColorString(GetStringByStrRef(nStrRefToDisplay), 255, nGreen, nBlue);

    // Float the message.
    FloatingTextStringOnCreature(sText, oCreatureToFloatAbove, bBroadcastToFaction);
}


