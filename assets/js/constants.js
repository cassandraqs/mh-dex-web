// This file contains global constants that will be used across the
// application.

WEAPON_TABLE_HEADERS = {
    "name": "Name",
    "rare": "Rare",
    "slots": "Slots",
    "damage": "Damage",
    "affinity": "Affinity",
    "special": "Special",
    "defense": "Defense",
    "sharpness": "Sharpness"
};


WEAPON_SHARPNESS_COLORS = [
    "#D52B00",
    "#FF732C",
    "#FFFF66",
    "#66FF33",
    "#3399FF",
    "#FCFCFC",
    "#9900FF"
];

WEAPON_SPECIAL_ATTACKS = [
    {name: "none", color: "#000000"},
    {name: "fire", color: "#FF4719"},
    {name: "water", color: "#0066FF"},
    {name: "thunder", color: "#E6E65C"},
    {name: "ice", color: "#66CCFF"},
    {name: "dragon", color: "#9900CC"},
    {name: "poison", color: "#B8008A"},
    {name: "paralyze", color: "#FFFF66"},
    {name: "sleep", color: "#33CC33"},
    {name: "blast", color: "#FF8533"}
]

AUX = {
    range: function(start, end) {
        var result = [];
        for (var i = start; i < end; ++i) {
            result.push(i);
        }
        return result;
    }
}
