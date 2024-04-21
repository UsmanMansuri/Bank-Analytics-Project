use project;
select * from finance_1;
SELECT * from finance_2;

# KPI 1 Year wise loan amount Stats ##
 
 select year(issue_d) as issue_year , sum(loan_amnt) as total_loan_amnt
 from finance_1
 group by issue_year
 order by total_loan_amnt desc;
 
 #  KPI 2 Grade and sub grade wise revol_bal  ##
##the columns are in the two different table so we have to use inner join ##

select grade, sub_grade, sum(revol_bal) as revolving_balance
from finance_1 
inner join finance_2
on finance_1.id=finance_2.id
group by grade, sub_grade;

# KPI 3 Total Payment for Verified Status Vs Total Payment for Non Verified Status  ##

select verification_status , concat("$",format(round(sum(total_pymnt)/1000000,2),2),"M") as total_payment
from finance_1 
inner join finance_2
on (finance_1.id=finance_2.id)
group  by verification_status;


##  KPI 4 State wise and month wise loan status  #

select addr_state, loan_status, count(loan_status)
from finance_1
group by addr_state, loan_status;

select monthname(f2.last_pymnt_d) as pay_month, count(f1.loan_status) as loan_status
from finance_1 as f1 join finance_2 as f2
on f1.id = f2.id
group by pay_month;

# KPI 5 Home ownership Vs last payment date stats   ##

select home_ownership , last_pymnt_d, concat("$",format(round(sum(last_pymnt_amnt)/10000,2),2),"k") as last_payment_amount
from finance_1 inner join finance_2
 on (finance_1.id=finance_2.id)
group by home_ownership , last_pymnt_d
order by home_ownership desc, last_pymnt_d;


