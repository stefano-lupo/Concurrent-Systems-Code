byte n =0, finish = 0;

active [2] proctype P() {
    byte reg, counter = 0;
    do 
        :: counter == 10 -> break
        :: else ->
            reg = n;
            reg ++;
            n = reg;
            counter++;
    od;
    finish++;
}

active proctype WaitForFinsih() {
    finish == 2;
    printf("n = %d\n",n);
    assert(n>=10);
}