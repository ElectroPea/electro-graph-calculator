function add_parentheses(expression) {
    expression = string_replace_all(expression, " ", "");
    
    var tokens = [];
    var current_token = "";
    var ops = "+-*/^()";
    
    for (var i = 1; i <= string_length(expression); i++) {
        var char = string_char_at(expression, i);
        if (string_pos(char, ops) > 0) {
            if (current_token != "") array_push(tokens, current_token);
            array_push(tokens, char);
            current_token = "";
        } else {
            current_token += char;
        }
    }
    if (current_token != "") array_push(tokens, current_token);
    
    return parse_expression(tokens, 0, array_length(tokens));
}

function parse_expression(tokens, start, endl) {
    if (start >= endl) return "";
    if (endl - start == 1) return string(tokens[start]);

    var balance = 0;
    var all_enclosed = (tokens[start] == "(" && tokens[endl - 1] == ")");
    if (all_enclosed) {
        for (var i = start; i < endl - 1; i++) {
            if (tokens[i] == "(") balance++;
            else if (tokens[i] == ")") balance--;
            if (balance == 0) { all_enclosed = false; break; }
        }
        if (all_enclosed) return parse_expression(tokens, start + 1, endl - 1);
    }

    var operator_pos = -1;
    var min_precedence = 1000;
    balance = 0;

    for (var i = endl - 1; i >= start; i--) {
        var token = tokens[i];
        if (token == ")") balance++;
        else if (token == "(") balance--;
        else if (balance == 0) {
            var pr = -1;
            if (token == "+" || token == "-") pr = 1;
            else if (token == "*" || token == "/") pr = 2;
            else if (token == "^") pr = 3;
            
            if (pr != -1 && pr < min_precedence) {
                min_precedence = pr;
                operator_pos = i;
            }
        }
    }

    if (operator_pos != -1) {
        var left = parse_expression(tokens, start, operator_pos);
        var right = parse_expression(tokens, operator_pos + 1, endl);
        return "(" + left + tokens[operator_pos] + right + ")";
    }

    var res = "";
    for (var i = start; i < endl; i++) res += string(tokens[i]);
    return res;
}
