import java.util.*;
public class PasswordValidator
{
    public static void main(String[] args)
    {
        // user input(password for validation)
        Scanner sc = new Scanner(System.in);
        boolean v = false;
        while(!v)
        {
            System.out.println("Enter your password");
            String str = sc.next();
            // function call to validate the password
            v=validatePass(str);
            if(v){
                System.out.println("passsword is Valid");
                break;
            }
        }
    }

    // method to validate the user password 
    public static boolean validatePass(String s)
    {
        boolean chrtr = false;
        boolean digt = false;
        boolean spcl = false;

        if(s.length()<8)
        {
            System.out.println("Password is Too Short");
            return false;
        }
        else{
            for(char ch : s.toCharArray())
            {
                // checking for uppercase
                if(Character.isUpperCase(ch))
                {
                    chrtr=true;
                }
                // checking for digit 
                if(Character.isDigit(ch))
                {
                    digt=true;
                }
                // checking for special character
                if(!Character.isLetterOrDigit(ch))
                {
                    spcl=true;
                }
            }
            if(chrtr==false)
            {
                System.out.println("Missing Uppercase Letter");
            }
            if(digt==false)
            {
                System.out.println("Missing digit");
            }
            if(spcl==false)
            {
                System.out.println("Missing special Character");
            }
        }
        return chrtr && digt && spcl && s.length()>=8;
    }
}