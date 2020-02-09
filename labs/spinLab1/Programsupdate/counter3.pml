
int count = 0;
int executionCounts=0;

init{

    run p();
    run q();
    (executionCounts == 4);
    assert(count == 4);
}

proctype p()
{
    int x = 1;
    do
        ::x==1 ->
            count++;
            printf("\nCount (P, x=%d) = %d\n", x,count);
            x++;
            executionCounts++;
        ::x==2->
            count++;
            printf("\nCount (P, x=%d) = %d\n", x,count);
            x++;
            executionCounts++;
        ::else -> break;
    od
        
}

proctype q()
{
    int x = 1;
    int localCount;
    do
        ::x==1 ->
            localCount= count;
            localCount++;
            count = localCount;
            printf("\nCount (Q, x=%d) = %d\n", x,count);
            x++;
            executionCounts++;
        ::x==2->
            localCount = count;
            localCount++;
            count = localCount;
            printf("\nCount (Q, x=%d) = %d\n", x,count);
            x++;
            executionCounts++;
        ::else -> break;
    od
}
