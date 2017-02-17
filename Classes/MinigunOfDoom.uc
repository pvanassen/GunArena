class MinigunOfDoom extends Minigun
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

	bUseOldWeaponMesh = class'Minigun'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'Minigun'.Default.ExchangeFireModes;
	Priority = class'Minigun'.Default.Priority;
	CustomCrosshair = class'Minigun'.Default.CustomCrosshair;
	CustomCrossHairColor = class'Minigun'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'Minigun'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'Minigun'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
