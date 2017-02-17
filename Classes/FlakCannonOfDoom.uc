class FlakCannonOfDoom extends FlakCannon
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

	bUseOldWeaponMesh = class'FlakCannon'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'FlakCannon'.Default.ExchangeFireModes;
	Priority = class'FlakCannon'.Default.Priority;
	CustomCrosshair = class'FlakCannon'.Default.CustomCrosshair;
	CustomCrossHairColor = class'FlakCannon'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'FlakCannon'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'FlakCannon'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
