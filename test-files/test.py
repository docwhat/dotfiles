#  File:       13-05.py
#  Purpose:    OOP Example: Student class inherits from Person class
#  Programmer: Anne Dawson
#  Course:     CSCI120
#  Date:       Monday 28th November 2016, 7:22 PT
#  References: http://www.annedawson.net/Python3_Intro_OOP.odp
#              http://www.annedawson.net/Python3_Prog_OOP.odp


class Person:
    """Instantiates a Person object with given name. """

    def __init__(self, first_name, last_name):
        """Initializes private instance variables _firstname and _lastname. """
        self._firstname = first_name
        self._lastname = last_name

    def __str__(self):
        """Returns the state of the Person object. """
        return self._firstname + " " + self._lastname

    def getFirstname(self):  # accessor method
        """Returns the instance variable _firstname. """
        return self._firstname

    def getLastname(self):  # accessor method
        """Returns the instance variable _lastname. """
        return self._lastname

    def setFirstname(self, newFirstname):  # mutator method
        """Assign a value to the instance variable _firstname. """
        self._firstname = newFirstname

    def setLastname(self, newLastname):  # mutator method
        """Assign a value to the instance variable _lastname. """
        self._lastname = newLastname

    def reverseName(self):  # method
        """Reverses the full name   """
        return self._lastname + " " + self._firstname


class Student(Person):
    """Instantiates a Student object with given name. """

    def __init__(self, first_name, last_name, student_number=0, G_P_A=0):
        """Initializes private instance variables _firstname, _lastname, _SN and _GPA. """
        super().__init__(first_name, last_name)  # import base's parameters
        """Initializes private instance variables _firstname and _lastname. """
        self._SN = student_number
        self._GPA = G_P_A

    def __str__(self):
        """Returns the state of the Student object. """
        return (
            self._firstname
            + " "
            + self._lastname
            + " "
            + str(self._SN)
            + " "
            + str(self._GPA)
        )

    def getSN(self):  # accessor method
        """Returns the instance variable _SN. """
        return self._SN

    def getGPA(self):  # accessor method
        """Returns the instance variable _GPA. """
        return self._GPA

    def setSN(self, newSN):  # mutator method
        """Assign a value to the instance variable _SN. """
        self._SN = newSN

    def setGPA(self, newGPA):  # mutator method
        """Assign a value to the instance variable _GPA. """
        self._GPA = newGPA

    def reverseName(self):  # method
        """Reverses the full name   """
        return self._lastname + " " + self._firstname + " " + str(self._GPA)


print(Student.__doc__)  # prints the docstring for the class
student1 = Student("Carol", "Wong")
student2 = Student("Bill", "Wang")
print(student1)  # calls the __str__ method implicitly on person1 object
print(student2)  # calls the __str__ method implicitly on person2 object
print(Student.getFirstname.__doc__)  # prints the docstring for the getFirstname method
print(Student.getGPA.__doc__)  # prints the docstring for the getGPA method
print(student1.getFirstname())
print(student1.getLastname())
print(student2.getFirstname())
print(student2.getLastname())
student1.setFirstname("Louisa")
print(student1.getFirstname())
print(student1.reverseName())  # The reverseName method of the Student class
# overrides the same method of the Parent class.
# This is an example of polymorphism
