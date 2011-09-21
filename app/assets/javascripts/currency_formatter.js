Number.prototype.toCurrency = function($O) { // extending Number prototype

    String.prototype.separate_thousands = function() { // Thousands separation
        $val = this;
        var rx = new RegExp('(-?[0-9]+)([0-9]{3})');
        while(rx.test($val)) { $val = $val.replace(rx, '$1'+$O.thousands_separator+'$2'); }
        return $val;
    }

    Number.prototype.toFixed = function() { // Rounding
        var m = Math.pow(10,$O.use_fractions.fractions);
        return Math.round(this*m,0)/m;
    }

    String.prototype.times = function(by) { // String multiplication
        by = (by >> 0);
        var t = (by > 1? this.times(by / 2): '' );
        return t + (by % 2? t + this: t);
    }

    var $A = this;

    /* I like to keep all options, as the name would sugesst, **optional** :) so, let me make tham as such */
    $O ? null : $O = new Object;
    /* If no thousands_separator is present default to "," */
    $O.thousands_separator ? null : $O.thousands_separator = ",";
    /* If no currency_symbol is present default to "$" */
    $O.currency_symbol ? null : $O.currency_symbol = "$";

    // Fractions use is separated, just in case you don't want them
    if ($O.use_fractions) {
        $O.use_fractions.fractions ? null : $O.use_fractions.fractions = 2;
        $O.use_fractions.fraction_separator ? null : $O.use_fractions.fraction_separator = ".";         
    } else {
        $O.use_fractions = new Object;
        $O.use_fractions.fractions = 0;
        $O.use_fractions.fraction_separator = " ";
    }
    // We round this number
    $A.round = $A.toFixed();

    // We convert rounded Number to String and split it to integrer and fractions
    $A.arr = ($A.round+"").split(".");
    // First part is an integrer
    $A._int = $A.arr[0].separate_thousands();
    // Second part, if exists, are rounded decimals
    $A.arr[1] == undefined ? $A._dec = $O.use_fractions.fraction_separator+"0".times($O.use_fractions.fractions) : $A._dec = $O.use_fractions.fraction_separator+$A.arr[1];

    /* If no symbol_position is present, default to "front" */
    $O.symbol_position ? null : $O.symbol_position = "front";
    $O.symbol_position == "front" ? $A.ret = $O.currency_symbol+$A._int+$A._dec : $A.ret = $A._int+$A._dec+" "+$O.currency_symbol;
    return $A.ret;
}

function SeparateThousands(str) { // Thousands separation
    $val = str.toString();
    var rx = new RegExp('(-?[0-9]+)([0-9]{3})');
    while(rx.test($val)) { $val = $val.replace(rx, '$1'+','+'$2'); }
    return $val;
}


function FormatCurrency(amount){
  return parseFloat(amount).toCurrency()
}
