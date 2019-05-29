class Manager < Employee

    def initialize(name, title, salary, boss, employees)
        super(name, title, salary, boss)
        @employees = employees
    end
    
    def bonus(multiplier)
        final = 0
        @employees.each do |employee|
            final += employee.salary
        end
        final * multiplier
    end
    
    
end