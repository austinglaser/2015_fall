#include <iostream>
#include "Student.h"
using namespace std;

int main()
{
	Student liz = Student("Liz");
	//cout << liz << endl;				// can't do this 
	//cout << liz.firstName << endl;	// can't do this
	cout << liz.getFirstName() << endl;
}
