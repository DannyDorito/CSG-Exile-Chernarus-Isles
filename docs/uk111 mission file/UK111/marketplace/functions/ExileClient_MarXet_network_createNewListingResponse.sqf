private["_vehicleCheck","_itemClassname","_price","_location","_containersBefore","_containersAfter","_configName","_name","_dialog"];
_vehicleCheck = _this select 0;
_itemClassname = _this select 1;
_price = _this select 2;
_location = _this select 3;
if !(_vehicleCheck) then {
    switch (_location) do {
        case 0: {
            _containersBefore = [uniform player, vest player, backpack player];
            [player, _itemClassname] call ExileClient_util_playerCargo_remove;
            _containersAfter = [uniform player, vest player, backpack player];
            if !(_containersAfter isEqualTo _containersBefore) then {
                ["LoadDropdown","Left"] call ExileClient_MarXet_gui_load;
            };
        };
        case 1: { [(uniformContainer player), _itemClassname] call ExileClient_util_containerCargo_remove; };
        case 2: { [(vestContainer player), _itemClassname] call ExileClient_util_containerCargo_remove; };
        case 3: { [(backpackContainer player), _itemClassname] call ExileClient_util_containerCargo_remove; };
    };
};
_configName = _itemClassname call ExileClient_util_gear_getConfigNameByClassName;
_name = getText(configFile >> _configName >> _itemClassname >> "displayName");
["SuccessTitleAndText", ["Marketplace",format["You have successfully listed your <t color='#ff0000'>%1</t> for <t color='#ff0000'>%2</t><img image='\exile_assets\texture\ui\poptab_inline_ca.paa' size='24'/> on marketplace", _name, _price]]] call ExileClient_gui_toaster_addTemplateToast;
_dialog = uiNameSpace getVariable ["RscMarXetDialog", displayNull];
if !(_dialog isEqualTo displayNull) then {
    ["Sort",MarXet_Sorting] call ExileClient_MarXet_gui_load;
    ["LoadLeft"] call ExileClient_MarXet_gui_load;
    ["LoadRight"] call ExileClient_MarXet_gui_load;
};
