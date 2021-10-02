#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH  640
#define FRAME_HEIGHT 480

#define FRAME_BUFFER_DEVICE "/dev/fb0"

extern  team,member1, member2, member3;
extern int ID1,ID2,ID3, IDtotal;


/*************************************************************
 *  <<Julia set?賊?鞈?>>
 *  https://en.wikipedia.org/wiki/Julia_set
 *
 *  cX ??Julia set?詨飛撘葉銴 "c" ?祕??
 *  cY ??Julia set?詨飛撘葉銴 "c" ????
 *  隤踵cX(?澆?:-1.0~1.0)?Y(?澆?:0.0~1.0)?臬??唬????耦
 *

*************************************************************/


int main()
{
 //RGB16
 int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

 int max_cX = -700;
 int min_cY = 270;

 int cY_step = -5;
 int cX = -700; // x = -700~-700
 int cY;   // y = 400~270

 int fd;

 printf( "Function1: Name\n" );

 //Dummy Function. Please refer to the specification of Project 1.
 name();

 printf( "Function2: ID\n" );

 //Dummy Function. Please refer to the specification of Project 1.
 id();

 //Dummy printout. Please refer to the specification of Project 1.
 printf( "Main Function:\n" );
 printf( "*****Print All*****\n" );
 printf( "by Team 07\n" );
 printf( "%d  %s ", ID1, &member1 );
 printf( "%d  %s ", ID2, &member2 );
 printf( "%d  %s ", ID3, &member3 ) ;

 printf( "ID Summation = %d\n", IDtotal );
 printf( "*****End Print*****\n" );


 printf( "\n***** Please enter p to draw Julia Set animation *****\n" );

 while(getchar()!='p') {}


 system( "clear" );


 fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

 if( fd<0 )
 { printf( "Frame Buffer Device Open Error!!\n" ); }
 else
 {
  for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {

   drawJuliaSet( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );

   write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );


   lseek( fd, 0, SEEK_SET );
  }


  //Dummy printout. Please refer to the specification of Project 1.

  printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
  printf( "by Team 07\n" );
  printf( "10727102   Kai Chen\n" );
  printf( "10727147   Hao Ming\n" );
  printf( "10727157   Kon Hong\n" );

  close( fd );
 }


 while(getchar()!='p') {}

 return 0;
}
