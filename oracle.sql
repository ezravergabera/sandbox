-- Chapter 3
select distinct student.ID, student.name
from student
inner join takes on student.ID = takes.ID
inner join course on takes.course_id = course.course_id
where course.dept_name = 'Comp. Sci.';

select student.ID, student.name
from student
where not exists (select *
                    from takes
                    where takes.ID = student.ID
                    and takes.year < 2017);

select instructor.dept_name as "Department", max(instructor.salary) as "Total Salary"
from instructor
group by instructor.dept_name;

with totalSalary_of_departments(dept_name, max_salary) as
    (select instructor.dept_name, max(instructor.salary)
    from instructor
    group by instructor.dept_name)

select min(max_salary) as "Total Salary"
from totalSalary_of_departments;

insert into course values ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 0);

insert into section (course_id, sec_id, semester, year)
values ('CS-001', 1, 'Fall', 2017);

insert into takes (id, course_id, sec_id, semester, year)
select student.id, 'CS-001', 1, 'Fall', 2017
from student
where student.dept_name = 'Comp. Sci.';

delete from takes
where ID = 12345 and (course_id, sec_id, semester, year) = ('CS-001', 1, 'Fall', 2017);

delete from course
where course_id = 'CS-001';

delete from takes
where course_id in (select course_id
                        from course
                        where lower(title) like '%advanced%');


create table person (
    driver_id varchar(15),
    name varchar(30) not null,
    address varchar(40),
    primary key (driver_id)
);

create table car (
    license_plate varchar(8),
    model varchar(7),
    year numeric(4, 0) check (year > 1701 and year < 2100),
    primary key (license_plate)
);

create table accident (
    report_number varchar(10),
    year numeric(4, 0) check (year > 1701 and year <2100),
    location varchar(30),
    primary key (report_number)
);

create table owns (
    driver_id varchar(15),
    license_plate varchar(8),
    primary key (driver_id, license_plate),
    foreign key (driver_id) references person(driver_id) on delete cascade,
    foreign key (license_plate) references car(license_plate) on delete cascade
);

create table participated (
    report_number varchar(10),
    license_plate varchar(8),
    driver_id varchar(15),
    damage_amount numeric(10, 2),
    primary key (report_number, license_plate),
    foreign key (report_number) references accident(report_number),
    foreign key (license_plate) references car(license_plate)
);

with allCarsOf_JohnSmith(license_plate) as
    (select license_plate
        from person inner join owns on person.driver_id = owns.driver_id
        where person.name = 'John Smith')
        
select count(distinct report_number) as "Total Accidents of John Smith"
from participated
where license_plate in (select license_plate from allCarsOf_JohnSmith);

update participated
set participated.damage_amount = 3000
where report_number = 'AR2197' and license_plate = 'AABB2000';

with allBranchesIn_Brooklyn(branch_name) as
    (select branch_name
        from branch
        where branch_city = 'Brooklyn')

select C.ID, C.customer_name
from customer C
where not exists (select branch_name from allBranchesIn_Brooklyn)
                    except
                (select branch_name
                from account
                    inner join depositor on account.account_number = depositor.account_number
                where depositor.ID = C.ID);

select sum(amount) as "Total Sum"
from loan;

select branch_name
from branch
where assets > some (select assets
                        from branch
                        where branch_city = 'Brooklyn');

select E.id, E.person_name
from employee E
inner join works on E.id = works.id
inner join company on works.company_name = company.company_name
where E.city = company.city;

select E.id, E.person_name
from employee E
inner join manages on E.id = manages.id
inner join employee manager_of_E on manages.manager_id = managerOf_E.id
where E.street = managerOf_E.street
    and E.city = managerOf_E.city;

with averageSalaryPerCompany(company_name, avg_salary) as
    (select company_name, avg(salary)
    from works
    group by company_name)

select E.id, E.person_name
from employee E
inner join works on E.id = works.id
where works.salary > (select avg_salary
                        from averageSalaryPerCompany
                        where company_name = works.company_name);

select company_name, sum(salary) as "Total Salary"
from works
group by company_name
order by "Total Salary"
fetch first 1 row only;

update works
set salary = salary * 1.1
where company_name = 'First Bank Corporation';

update works
set salary = salary * 1.1
where company_name = 'First Bank Corporation'
and id in (select manager_id
            from manages);

delete form works
where company_name = 'Small Bank Corporation';

create table employee (
    id varchar(8),
    person_name varchar(30) not null,
    street varchar(40),
    city varchar(30),
    primary key(id)
);

create table company (
    company_name varchar(40),
    city varchar(30),
    primary key(company_name)
);

create table works (
    id varchar(8),
    company_name varchar(40),
    salary numeric(10, 2) check (salary > 10000),
    primary key(id),
    foreign key(id) references employee(id) on delete cascade,
    foreign key(company_name) references company(company_name) on delete cascade
);

create table manages (
    id varchar(8),
    manager_id varchar(8),
    primary key(id),
    foreign key(id) references employee(id),
    foreign key(manager_id) references employee(id)
);

select x
from r1
where x <> all (select k
                    from r2);

select x
from r1
where x not in (select k
                    from r2);

select memb_no, name
from member M
where exists (select *
                from book
                inner join borrowed on book.isbn = borrowed.isbn
                where book.publisher = 'McGraw-Hill'
                and borrowed.memb_no = M.memb_no);

select memb_no, name
from member M
where not exists (
    (
        select isbn
        from book
        where publisher = 'McGraw-Hill'
    )
    except
    (
        select isbn
        from borrowed
        where memb_no = M.memb_no
    )
);

with borrowedBook_Member(memb_no, memb_name, isbn, title, authors, publisher, date) as
    (select M.memb_no, M.name, B.isbn, B.title, B.authors, B.publisher, borrowed.date
    from member M
    inner join borrowed on M.memb_no = borrowed.memb_no
    inner join book B on borrowed.isbn = B.isbn)

select memb_no, memb_name, publisher, count(isbn)
from borrowedBook_Member
group by memb_no, memb_name, publisher
having count(isbn) > 5;

with no_of_borrowedBooks(memb_no, memb_name, numberOfBooks) as
    (select memb_no, name, (
        case
            when not exists (select * from borrowed where borrowed.memb_no = member.memb_no) then 0
            else (select count(*) from borrowed where borrowed.memb_no = member.memb_no)
        end
    )
    from member)

select avg(numberOfBooks) as "Average Number of Books Borrowed per Member"
from no_of_borrowedBooks;

select title
from course c1
where not exists (select 1
                    from course 2
                    where c1.course_id != c2.course_id
                    and c1.title = c2. title);

select dept_name
from (select dept_name, sum(salary) value
        from instructor
        group by dept_name) as dept_total, (select avg(value) value
                                                from (select dept_name, sum(salary) value
                                                        from instructor
                                                        group by dept_name) x) as dept_total_avg
where dept_total.value >= dept_total_avg.value;

select S.ID, S.name
from student S
inner join advisor A on S.ID = A.S_ID
inner join instructor I on A.I_ID = I.ID
where S.dept_name = 'Accounting'
and I.dept_name = 'Physics';

select dept_name
from department
where budget > (select budget from department where dept_name = 'Philosophy')
order by dept_name asc;

select id, course_id
from takes
group by id, course_id
having count(*) >= 3
order by course_id asc;

with retakers(id, course_id, frequency) as
    (select id, course_id, count(*)
    from takes
    group by id, course_id
    having count(*) > 1)

select id
from retakers
group by id
having count(*) >= 3;

select id, name
from instructor I
where not exists ((select course_id
                    from course
                    where dept_name = I.dept_name)
                except
                (select course_id
                from teaches
                where teaches.id = I.id))
order by name asc;

select id, name
from student s
where dept_name = 'History'
and name like 'D%'
and (select count(distinct course_id)
    from takes
    where takes.id = S.id
    and course_id in (select course_id from course where dept_name = 'Music')
) < 5;

select id, name
from instructor i
where 'A' not in (select t.grade
                    from takes t
                    inner join teaches te on t.course_id = te.course_id
                    and t.sec_id = te.sec_id
                    and t.semester = te.semester
                    and t.year = te.year
                    where te.id = I.id);

select id, name
from instructor i
where 'A' not in (select t.grade
                    from takes t
                    inner join teaches te on t.course_id = te.course_id
                    and t.sec_id = te.sec_id
                    and t.semester = te.semester
                    and t.year = te.year
                    where te.id = I.id)
                and
                (select count(*)
                from takes t
                inner join teaches te on t.course_id = te.course_id
                    and t.sec_id = te.sec_id
                    and t.semester = te.semester
                    and t.year = te.year
                    where te.id = I.id
                    and t.grade is not null) >= 1;

select course_id, title
from course c
where dept_name = 'Comp. Sci.'
and exists (select *
            from section
            where section.course_id = c.course_id
            and time_slot_id in (select time_slot_id
                                from time_slot
                                where end_hr >= 12));

select course_id, sec_id, year, semester, count(distinct id) as num
from takes
group by course_id, sec_id, year, semester;

with sectionStudentFrequency(course_id, sec_id, year, semester, num) as
    (select course_id, sec_id, year, semester, count(distinct ID)
    from takes
    group by course_id, sec_id, year, semester)

select *
from sectionStudentFrequency
where num = (select max(num)
                from sectionStudentFrequency);

-- Chapter 5
