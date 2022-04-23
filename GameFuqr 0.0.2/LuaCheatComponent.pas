unit LuaGameFuqRComponent;

{$mode delphi}

interface

uses
  Classes, SysUtils,lua, lualib, lauxlib, LuaHandler, LuaCaller,
  ExtCtrls, StdCtrls, ExtraTrainerComponents;

procedure initializeLuaGameFuqRComponent;

implementation

uses LuaClass, LuaWinControl;

function GameFuqRcomponent_getActive(L: PLua_State): integer; cdecl;
var
  GameFuqRcomponent: TGameFuqR;
begin
  GameFuqRcomponent:=luaclass_getClassObject(L);
  lua_pushboolean(L, GameFuqRcomponent.activated);
  result:=1;
end;


function GameFuqRcomponent_setActive(L: PLua_State): integer; cdecl;
var
  paramstart, paramcount: integer;
  GameFuqRcomponent: TGameFuqR;

  deactivatetime: integer;
  t: TTimer;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L, @paramstart, @paramcount);


  if paramcount>=1 then
  begin
    GameFuqRcomponent.activated:=lua_toboolean(L,paramstart);

    if paramcount=2 then
    begin
      deactivatetime:=lua_tointeger(L,paramstart+1);
      if GameFuqRcomponent.activated then
        GameFuqRcomponent.setDeactivateTimer(deactivatetime);

    end;
  end;
end;

function GameFuqRcomponent_getDescription(L: PLua_State): integer; cdecl;
var
  parameters: integer;
  GameFuqRcomponent: TGameFuqR;
begin
  GameFuqRcomponent:=luaclass_getClassObject(L);
  lua_pushstring(L, GameFuqRcomponent.Description);
  result:=1;
end;


function GameFuqRcomponent_setDescription(L: PLua_State): integer; cdecl;
var
  parameters: integer;
  GameFuqRcomponent: TGameFuqR;

  deactivatetime: integer;
  t: TTimer;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);

  if lua_gettop(L)>=1 then
    GameFuqRcomponent.Description:=Lua_ToString(L,-1);
end;

function GameFuqRcomponent_getHotkey(L: PLua_State): integer; cdecl;
var
  parameters: integer;
  GameFuqRcomponent: TGameFuqR;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);
  lua_pushstring(L, GameFuqRcomponent.Hotkey);
  result:=1;
end;


function GameFuqRcomponent_setHotkey(L: PLua_State): integer; cdecl;
var
  GameFuqRcomponent: TGameFuqR;

  deactivatetime: integer;
  t: TTimer;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);
  if lua_gettop(L)>=1 then
    GameFuqRcomponent.Hotkey:=Lua_ToString(L,-1);
end;

function GameFuqRcomponent_getDescriptionLeft(L: PLua_State): integer; cdecl;
var
  GameFuqRcomponent: TGameFuqR;
begin
  GameFuqRcomponent:=luaclass_getClassObject(L);
  lua_pushinteger(L, GameFuqRcomponent.DescriptionLeft);
  result:=1;
end;


function GameFuqRcomponent_setDescriptionLeft(L: PLua_State): integer; cdecl;
var
  parameters: integer;
  GameFuqRcomponent: TGameFuqR;

  deactivatetime: integer;
  t: TTimer;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);

  if lua_gettop(L)>=1 then
    GameFuqRcomponent.Descriptionleft:=lua_tointeger(L,-1);
end;


function GameFuqRcomponent_getHotkeyLeft(L: PLua_State): integer; cdecl;
var
  parameters: integer;
  GameFuqRcomponent: TGameFuqR;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);
  lua_pushinteger(L, GameFuqRcomponent.Hotkeyleft);
  result:=1;
end;


function GameFuqRcomponent_setHotkeyLeft(L: PLua_State): integer; cdecl;
var
  GameFuqRcomponent: TGameFuqR;

  deactivatetime: integer;
  t: TTimer;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);
  if lua_gettop(L)>=1 then
    GameFuqRcomponent.Hotkeyleft:=lua_tointeger(L,-1);
end;

function GameFuqRcomponent_getEditValue(L: PLua_State): integer; cdecl;
var
  GameFuqRcomponent: TGameFuqR;
begin
  GameFuqRcomponent:=luaclass_getClassObject(L);
  lua_pushstring(L, GameFuqRcomponent.EditValue);
  result:=1;
end;


function GameFuqRcomponent_setEditValue(L: PLua_State): integer; cdecl;
var
  parameters: integer;
  GameFuqRcomponent: TGameFuqR;

  deactivatetime: integer;
  t: TTimer;
begin
  result:=0;
  GameFuqRcomponent:=luaclass_getClassObject(L);
  if lua_gettop(L)>=1 then
    GameFuqRcomponent.EditValue:=Lua_ToString(L,-1);
end;

procedure GameFuqRcomponent_addMetaData(L: PLua_state; metatable: integer; userdata: integer );
begin
  wincontrol_addMetaData(L, metatable, userdata);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'setActive', GameFuqRcomponent_setActive);
  luaclass_addClassFunctionToTable(L, metatable, userdata, 'getActive', GameFuqRcomponent_getActive);
end;

procedure initializeLuaGameFuqRComponent;
begin
  Lua_register(LuaVM, 'GameFuqRcomponent_setActive', GameFuqRcomponent_setActive);
  Lua_register(LuaVM, 'GameFuqRcomponent_getActive', GameFuqRcomponent_getActive);
  Lua_register(LuaVM, 'GameFuqRcomponent_setDescription', GameFuqRcomponent_setDescription);
  Lua_register(LuaVM, 'GameFuqRcomponent_getDescription', GameFuqRcomponent_getDescription);
  Lua_register(LuaVM, 'GameFuqRcomponent_setHotkey', GameFuqRcomponent_setHotkey);
  Lua_register(LuaVM, 'GameFuqRcomponent_getHotkey', GameFuqRcomponent_getHotkey);
  Lua_register(LuaVM, 'GameFuqRcomponent_setDescriptionLeft', GameFuqRcomponent_setDescriptionLeft);
  Lua_register(LuaVM, 'GameFuqRcomponent_getDescriptionLeft', GameFuqRcomponent_getDescriptionLeft);
  Lua_register(LuaVM, 'GameFuqRcomponent_setHotkeyLeft', GameFuqRcomponent_setHotkeyLeft);
  Lua_register(LuaVM, 'GameFuqRcomponent_getHotkeyLeft', GameFuqRcomponent_getHotkeyLeft);
  Lua_register(LuaVM, 'GameFuqRcomponent_setEditValue', GameFuqRcomponent_setEditValue);
  Lua_register(LuaVM, 'GameFuqRcomponent_getEditValue', GameFuqRcomponent_getEditValue);
end;

initialization
  luaclass_register(TGameFuqR, GameFuqRcomponent_addMetaData);


end.

