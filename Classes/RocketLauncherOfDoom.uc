class RocketLauncherOfDoom extends RocketLauncher
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

	bUseOldWeaponMesh = class'RocketLauncher'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'RocketLauncher'.Default.ExchangeFireModes;
	Priority = class'RocketLauncher'.Default.Priority;
	CustomCrosshair = class'RocketLauncher'.Default.CustomCrosshair;
	CustomCrossHairColor = class'RocketLauncher'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'RocketLauncher'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'RocketLauncher'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
