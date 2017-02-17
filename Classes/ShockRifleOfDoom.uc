class ShockRifleOfDoom extends ShockRifle
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

	bUseOldWeaponMesh = class'ShockRifle'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'ShockRifle'.Default.ExchangeFireModes;
	Priority = class'ShockRifle'.Default.Priority;
	CustomCrosshair = class'ShockRifle'.Default.CustomCrosshair;
	CustomCrossHairColor = class'ShockRifle'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'ShockRifle'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'ShockRifle'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
