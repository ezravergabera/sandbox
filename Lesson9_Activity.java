import java.io.*;

class Student {
    String first_name;
    String last_name;
    String year;
    String course;
    String section;
    double midterm_grade;
    double final_grade;
    Student (String first_name, String last_name, String year, String course, String section, double midterm_grade, double final_grade) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.year = year;
        this.course = course;
        this.section = section;
        this.midterm_grade = midterm_grade;
        this.final_grade = final_grade;
    }
    void introduce_self() {
        System.out.println("\nMy name is " + first_name + " " + last_name + ", and I am currently in my " + year + " year of " + course + " in section " + section + " at Polytechnic University of the Philippines.");
    }
    void evaluate_grade() {
        double average = (midterm_grade + final_grade)/2;
        if (average > 100)
            System.out.println("Invalid Grade");
        else if (average >= 98)
            System.out.println("With Highest Honors");
        else if (average >= 95)
            System.out.println("With High Honors");
        else if (average >= 90)
            System.out.println("With Honors");
        else if (average >= 75)
            System.out.println("Passed");
        else
            System.out.println("Failed");
    }
}

public class Lesson9_Activity {
    public static void main (String[] args) throws IOException {
        BufferedReader console = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("Enter your first name: ");
        String first_name = console.readLine();
        System.out.println("Enter your last name: ");
        String last_name = console.readLine();
        System.out.println("Enter your year: ");
        String year = console.readLine();
        System.out.println("Enter your course: ");
        String course = console.readLine();
        System.out.println("Enter your section: ");
        String section = console.readLine();
        System.out.println("Enter your Midterm grade: ");
        double midterm_grade = Double.parseDouble(console.readLine());
        System.out.println("Enter your Final grade: ");
        double final_grade = Double.parseDouble(console.readLine());
        Student s = new Student(first_name, last_name, year, course, section, midterm_grade, final_grade);
        s.introduce_self();
        s.evaluate_grade();
    }
}