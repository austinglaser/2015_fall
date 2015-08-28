#include <iostream>
#include "Student.h"
using namespace std;

void Student::setNumCourses(int num)
{
	numCourses = num; 
}
void Student::setFirstName(string fn)
{
	firstName = fn;
}
string Student::getFirstName() 
{
	return firstName;
}
int Student::getNumCourses()
{
	return numCourses;
}
Student::Student(string fn)
{
	firstName = fn;
	numCourses = 0;
}
Student::Student()
{
	firstName = "Unknown";
	numCourses = 0;
}
