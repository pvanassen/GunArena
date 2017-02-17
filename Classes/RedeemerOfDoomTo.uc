class RedeemerOfDoomTo extends Redeemer
	HideDropDown
	CacheExempt
	config(GunArena);

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	bUseOldWeaponMesh = class'Redeemer'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'Redeemer'.Default.ExchangeFireModes;
	Priority = class'Redeemer'.Default.Priority;
	CustomCrosshair = class'Redeemer'.Default.CustomCrosshair;
	CustomCrossHairColor = class'Redeemer'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'Redeemer'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'Redeemer'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     FireModeClass(0)=Class'GunArena.RedeemerOfDoomToFire'
     FireModeClass(1)=Class'GunArena.RedeemerOfDoomToGuidedFire'
     bNoInstagibReplace=True
}
