using System;
using System.Collections.Generic;
using System.IO;


class BaseEmployee
{
    public int ID { get; set; }
    public string Name { get; set; }
    public string Role { get; set; }
    public double BasicPay { get; set; }
    public double Allowances { get; set; }
    public double Deductions { get; set; }

    public virtual double CalculateSalary()
    {
        return BasicPay + Allowances - Deductions;
    }

    public override string ToString()
    {
        return $"ID: {ID}, Name: {Name}, Role: {Role}, Basic Pay: {BasicPay}, Allowances: {Allowances}, Deductions: {Deductions}";
    }
}


class Manager : BaseEmployee
{
    public double Bonus { get; set; }

    public override double CalculateSalary()
    {
        return base.CalculateSalary() + Bonus;
    }
}

class Developer : BaseEmployee
{
    public double ProjectAllowance { get; set; }

    public override double CalculateSalary()
    {
        return base.CalculateSalary() + ProjectAllowance;
    }
}

class Intern : BaseEmployee
{
    public double Stipend { get; set; }

    public override double CalculateSalary()
    {
        return BasicPay + Stipend;
    }
}

class PayrollSystem
{
    private List<BaseEmployee> employees = new List<BaseEmployee>();
    private const string FilePath = "employees.txt";


    public void AddEmployee()
    {
        Console.WriteLine("Enter Employee Role (Manager/Developer/Intern):");
        string role = Console.ReadLine().Trim();
        BaseEmployee employee = role.ToLower() switch
        {
            "manager" => new Manager(),
            "developer" => new Developer(),
            "intern" => new Intern(),
            _ => null
        };

        if (employee == null)
        {
            Console.WriteLine("Invalid role.");
            return;
        }

        Console.WriteLine("Enter Employee ID:");
        employee.ID = int.Parse(Console.ReadLine());
        Console.WriteLine("Enter Employee Name:");
        employee.Name = Console.ReadLine();
        Console.WriteLine("Enter Basic Pay:");
        employee.BasicPay = double.Parse(Console.ReadLine());
        Console.WriteLine("Enter Allowances:");
        employee.Allowances = double.Parse(Console.ReadLine());
        Console.WriteLine("Enter Deductions:");
        employee.Deductions = double.Parse(Console.ReadLine());

        if (employee is Manager manager)
        {
            Console.WriteLine("Enter Bonus:");
            manager.Bonus = double.Parse(Console.ReadLine());
        }
        else if (employee is Developer developer)
        {
            Console.WriteLine("Enter Project Allowance:");
            developer.ProjectAllowance = double.Parse(Console.ReadLine());
        }
        else if (employee is Intern intern)
        {
            Console.WriteLine("Enter Stipend:");
            intern.Stipend = double.Parse(Console.ReadLine());
        }

        employees.Add(employee);
        Console.WriteLine("Employee added successfully.");
    }


    public void DisplayEmployees()
    {
        if (employees.Count == 0)
        {
            Console.WriteLine("No employees found.");
            return;
        }

        foreach (var employee in employees)
        {
            Console.WriteLine(employee);
        }
    }


    public void DisplaySalaries()
    {
        foreach (var employee in employees)
        {
            Console.WriteLine($"{employee.Name}'s Salary: {employee.CalculateSalary():C}");
        }
    }


    public void SaveToFile()
    {
        using StreamWriter writer = new StreamWriter(FilePath);
        foreach (var employee in employees)
        {
            writer.WriteLine(employee);
        }
        Console.WriteLine("Employees saved to file.");
    }

    public void LoadFromFile()
    {
        if (!File.Exists(FilePath))
        {
            Console.WriteLine("No saved data found.");
            return;
        }

        employees.Clear();
        foreach (var line in File.ReadLines(FilePath))
        {
            Console.WriteLine(line);
        }
        Console.WriteLine("Employees loaded from file.");
    }


    public void Menu()
    {
        while (true)
        {
            Console.WriteLine("\n--- Payroll System ---");
            Console.WriteLine("1. Add Employee");
            Console.WriteLine("2. Display Employees");
            Console.WriteLine("3. Display Salaries");
            Console.WriteLine("4. Save to File");
            Console.WriteLine("5. Load from File");
            Console.WriteLine("6. Exit");
            Console.WriteLine("---------------------------");
            Console.WriteLine("Enter your choice:");
            int choice = int.Parse(Console.ReadLine());

            switch (choice)
            {
                case 1:
                    AddEmployee();
                    break;
                case 2:
                    DisplayEmployees();
                    break;
                case 3:
                    DisplaySalaries();
                    break;
                case 4:
                    SaveToFile();
                    break;
                case 5:
                    LoadFromFile();
                    break;
                case 6:
                    return;
                default:
                    Console.WriteLine("Invalid choice. Try again.");
                    break;
            }
        }
    }
}
