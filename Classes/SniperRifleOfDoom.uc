class SniperRifleOfDoom extends SniperRifle
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

	bUseOldWeaponMesh = class'SniperRifle'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'SniperRifle'.Default.ExchangeFireModes;
	Priority = class'SniperRifle'.Default.Priority;
	CustomCrosshair = class'SniperRifle'.Default.CustomCrosshair;
	CustomCrossHairColor = class'SniperRifle'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'SniperRifle'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'SniperRifle'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
