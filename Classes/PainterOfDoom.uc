class PainterOfDoom extends Painter
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

	bUseOldWeaponMesh = class'Painter'.Default.bUseOldWeaponMesh;
	ExchangeFireModes = class'Painter'.Default.ExchangeFireModes;
	Priority = class'Painter'.Default.Priority;
	CustomCrosshair = class'Painter'.Default.CustomCrosshair;
	CustomCrossHairColor = class'Painter'.Default.CustomCrossHairColor;
	CustomCrossHairScale = class'Painter'.Default.CustomCrossHairScale;
	CustomCrossHairTextureName = class'Painter'.Default.CustomCrossHairTextureName;
}

defaultproperties
{
     bNoInstagibReplace=True
}
