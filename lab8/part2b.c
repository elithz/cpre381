#include <stdio.h>
#include <stdlib.h>


int X[1024000];
int	Y[1024000];
int Z[1024000];


int main()
{
	int i,j,k = 0;
	srand(time(NULL));
	
	
	
	
	
	for(i=0;i<1024000;i++)
	{	

		int ran;
		ran = rand() % 100;
		X[i] = ran;
			
	}
	for(j=0;j<1024000;j++)
	{

		int ran;
		ran = rand() %100;
		Y[j] = ran;
    }
	

	for(k=0;k<1024000;k++)
        {
			int ran = rand() % 1024000;

			Z[k] = X[ran] + Y[ran];
        }
	return 0;
}