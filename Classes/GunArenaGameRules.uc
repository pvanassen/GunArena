class GunArenaGameRules extends GameRules;

var bool bSelfDamage;

function int NetDamage(int OriginalDamage, int Damage, pawn injured, pawn instigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
	if(NextGameRules != None)
		Damage = NextGameRules.NetDamage(OriginalDamage, Damage, injured, instigatedBy, HitLocation, Momentum, DamageType);

	if (bSelfDamage)
	   return Damage;

	if(InstigatedBy != None && (InstigatedBy == Injured || InstigatedBy.Controller == Injured.Owner) && ClassIsChildOf(DamageType, class'WeaponDamageType'))
		Damage = 0;

	return Damage;
}

defaultproperties
{
}
