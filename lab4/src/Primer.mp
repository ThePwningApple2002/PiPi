MAIN
    int x;
    float y;
    bool flag;
    int counter;
    int result;

    x = 10;
    y = 3.14;
    flag = true;
    counter = x + 5;
    result = x - counter;
    y = x + y;

    for i in [x, counter, result] apply
        counter = counter + i;

    for j in [x, y] apply
        result = result + j
EXIT