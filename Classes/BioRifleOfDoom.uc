class BioRifleOfDoom extends BioRifle
	HideDropDown
	CacheExempt
	config(GunArena);

simulated function Fire(float F)
{
	SuperMaxOutAmmo();
}

simulated function AltFire(float F)
{
	SuperMaxOutAmmo();
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	bUseOldWeaponMesh = class'BioRifle'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'BioRifle'.Default.ExchangeFireModes;
	Priority = class'BioRifle'.Default.Priority;
	CustomCrosshair = class'BioRifle'.Default.CustomCrosshair;
	CustomCrossHairColor = class'BioRifle'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'BioRifle'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'BioRifle'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
