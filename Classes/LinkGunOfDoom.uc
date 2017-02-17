class LinkGunOfDoom extends LinkGun
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

	bUseOldWeaponMesh = class'LinkGun'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'LinkGun'.Default.ExchangeFireModes;
	Priority = class'LinkGun'.Default.Priority;
	CustomCrosshair = class'LinkGun'.Default.CustomCrosshair;
	CustomCrossHairColor = class'LinkGun'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'LinkGun'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'LinkGun'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
