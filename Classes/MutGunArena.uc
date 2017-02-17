//=============================================================================
// MutGunArena - Lead clothing would be a good idea.
// http://come.to/MrEvil
//=============================================================================
class MutGunArena extends Mutator
	config(GunArena);

var() config string ExtraWeaponClassName;
var() config bool bGiveExtraWeapon;
var() config string DefaultWeaponClassName;
var() config bool bSelfDamage;

var localized string GiveExtraDisplayText, GiveExtraDescText;
var localized string ExtraDisplayText, ExtraDescText;
var localized string DefaultDisplayText, DefaultDescText;

var string ExtraWeaponName; //Used for server query.

var localized string SelfDamageDisplayText, SelfDamagedescText;
var bool bInitialized;

/**
Check for URL override of configured arena weapon.
*/
function Initialize()
{
	local string Options;

	// get URL options
	Options = Level.GetLocalURL();
	Log(Options);
	if (bool(int(Left(Options, int(true)) != "?")))
		Options = Mid(Options, Instr(Options, "?"));

	if (class'GameInfo'.static.HasOption(Options, "bGiveExtraWeapon")) {
		if (class'GameInfo'.static.ParseOption(Options, "bGiveExtraWeapon") ~= "true") {
		  bGiveExtraWeapon = true;
		}
		else {
			bGiveExtraWeapon = false;
		}
	}

	if (class'GameInfo'.static.HasOption(Options, "ExtraWeaponClassName")) {
	  ExtraWeaponClassName = class'GameInfo'.static.ParseOption(Options, "ExtraWeaponClassName");
	}

	if (class'GameInfo'.static.HasOption(Options, "DefaultWeaponClassName")) {
	  ExtraWeaponClassName = class'GameInfo'.static.ParseOption(Options, "DefaultWeaponClassName");
	}

	if (class'GameInfo'.static.HasOption(Options, "bSelfDamage")) {
		if (class'GameInfo'.static.ParseOption(Options, "bSelfDamage") ~= "true") {
		  bSelfDamage = true;
		}
		else {
			bSelfDamage = false;
		}
	}
	bInitialized = true;
}

simulated function BeginPlay()
{
	local xPickupBase P;
	local Pickup L;
	foreach AllActors(class'xPickupBase', P)
	{
		P.bHidden = true;

		if(P.myEmitter != None)
			P.myEmitter.Destroy();
	}

	foreach AllActors(class'Pickup', L)
	{
		if(L.IsA('WeaponLocker'))
			L.GotoState('Disabled');
	}
	Super.BeginPlay();
}

function PostBeginPlay()
{
	if ( !bInitialized )
		Initialize();

	local GunArenaGameRules G;
	local class<Weapon> ExtraWeaponClass;
	local class<Weapon> DefaultWeaponClass;

	Super.PostBeginPlay();

	G = spawn(class'GunArenaGameRules');
	G.bSelfDamage = bSelfDamage;

	if(Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else
		Level.Game.GameRulesModifiers.AddGameRules(G);
  Log(DefaultWeaponClassName);
	DefaultWeaponClass = class<Weapon>(DynamicLoadObject(DefaultWeaponClassName, class'Class'));
	DefaultWeaponName = DefaultWeaponClassName; //DefaultWeaponClass.Default.ItemName;

	if(!bGiveExtraWeapon)
		return;

	if(ExtraWeaponClassName ~= "")
		return;

	Log(ExtraWeaponClassName);
	ExtraWeaponClass = class<Weapon>(DynamicLoadObject(ExtraWeaponClassName, class'Class'));

	if(ExtraWeaponClass != None)
		ExtraWeaponName = ExtraWeaponClass.Default.ItemName;
}

function bool AlwaysKeep(Actor Other)
{
	if(string(Other.Class) ~= DefaultWeaponName)
		return true;

	if(bGiveExtraWeapon && string(Other.Class) ~= ExtraWeaponClassName)
		return true;

	return Super.AlwaysKeep(Other);
}

function string GetInventoryClassOverride(string InventoryClassName)
{
	if(bGiveExtraWeapon && InventoryClassName ~= "XWeapons.AssaultRifle")
		return ExtraWeaponClassName;

	return Super.GetInventoryClassOverride(InventoryClassName);
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if(Other.IsA('Weapon'))
	{
		if(Other.IsA('TransLauncher') || Weapon(Other).bNoInstagibReplace)
		{
			bSuperRelevant = 0;
			return true;
		}

		Level.Game.bWeaponStay = false;
		return false;
	}
	if(Other.IsA('Ammo') || Other.IsA('WeaponPickup') || Other.IsA('WeaponLocker'))
	{
		return false;
	}

	bSuperRelevant = 0;
	return true;
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	local array<CacheManager.WeaponRecord> Recs;
	local string WeaponOptions;
	local int i;

	Super.FillPlayInfo(PlayInfo);

	class'CacheManager'.static.GetWeaponList(Recs);

	for(i = 0; i < Recs.Length; i++)
	{
		if (WeaponOptions != "")
			WeaponOptions $= ";";

		WeaponOptions $= Recs[i].ClassName $ ";" $ Recs[i].FriendlyName;
	}

	PlayInfo.AddSetting(default.RulesGroup, "DefaultWeaponClassName", default.DefaultDisplayText, 0, 1, "Select", WeaponOptions);
	PlayInfo.AddSetting(default.RulesGroup, "bSelfDamage", default.SelfDamageDisplayText, 0, 1, "Check");
	PlayInfo.AddSetting(default.RulesGroup, "bGiveExtraWeapon", default.GiveExtraDisplayText, 0, 1, "Check");
	PlayInfo.AddSetting(default.RulesGroup, "ExtraWeaponClassName", default.ExtraDisplayText, 0, 1, "Select", WeaponOptions);
}

static event string GetDescriptionText(string PropName)
{
	if(PropName == "bSelfDamage")
		return default.SelfDamageDescText;

	if(PropName == "bGiveExtraWeapon")
		return default.GiveExtraDescText;

	if(PropName == "ExtraWeaponClassName")
		return default.ExtraDescText;
	if (PropName == "DefaultWeaponClassName")
		return default.DefaultDescText;

	return Super.GetDescriptionText(PropName);
}

function GetServerDetails(out GameInfo.ServerResponseLine ServerState)
{
	local int i;

	Super.GetServerDetails(ServerState);

	i = ServerState.ServerInfo.Length;

	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "Self damage";
	ServerState.ServerInfo[i].Value = string(bSelfDamage);

	i++;
	ServerState.ServerInfo.Length = i+1;
	ServerState.ServerInfo[i].Key = "Extra starting weapon";

	if(bGiveExtraWeapon)
		ServerState.ServerInfo[i].Value = ExtraWeaponName;
	else
		ServerState.ServerInfo[i].Value = "None";
}

defaultproperties
{
     ExtraWeaponClassName="XWeapons.SniperRifle"
		 DefaultWeaponClassName="XWeapons.BioRifle"
     GiveExtraDisplayText="Start with extra weapon"
     GiveExtraDescText="If checked, players will start with one weapon in addition to the the default weapon. If unchecked, players start with only the default weapon."
     ExtraDisplayText="Extra starting weapon"
		 DefaultDisplayText="Default starting weapon"
     ExtraDescText="Players start with this weapon in addition to the default."
		 DefaultDescText="Default."
     bSelfDamage=True
     SelfDamageDisplayText="Self damage"
     SelfDamagedescText="If checked, players take normal damage from their own weapons. If unchecked, players cannot kill themselves with their own weapons."
     bAddToServerPackages=True
     GroupName="Arena"
     FriendlyName="Gun Arena"
     Description="All pickups removed and default weapon is a weapon of choice, sometimes with unlimited ammo."
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}
