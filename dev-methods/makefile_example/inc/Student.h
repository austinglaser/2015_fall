#ifndef STUDENT_H
#define STUDENT_H
class Student
{
  private:
	std::string firstName;
	int numCourses;
  public:
	Student();			// constructor
	Student(std::string fn);
	std::string getFirstName();
	int getNumCourses();
	void setFirstName(std::string fn);
	void setNumCourses(int num);
};
#endif
