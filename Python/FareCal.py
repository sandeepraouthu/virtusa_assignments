#fucntion to calculate final price
def calci_fare(dstnc, vech_type, hr):
    rates = {
        'economy': 10,
        'premium': 18,
        'suv': 25
    }
    #check if entered vechile type is present in the service
    if vech_type not in rates:
        return None
    
    # calculates basic price 
    rate_per_distance = rates[vech_type]
    basic_price = dstnc * rate_per_distance

    price_charged = False
    
    #apply surge pricing during peak hours 
    if hr >= 17 and hr <= 20:
        basic_price *= 1.5
        price_charged = True

    return basic_price, rate_per_distance, price_charged


#loop runs until user enters valid input
while True:
    try:
        dstnc = float(input("Enter Distance in Km : "))
        vech_type = input("Enter Vechile Type (premium/economy/suv) : ")
        hr = int(input("Enter the hours of travel (0-23) : "))

        result = calci_fare(dstnc, vech_type, hr)

        if result is None:
            print("Service not Available .")
            print("Please Try Again ")
            continue

        final_price, rate, surge = result
        
        #displays formatted ride receipt
        print("\n Ride details")
        print("distance       :", dstnc)
        print(f"Vehicle Type   : {vech_type.capitalize()}")
        print(f"Rate per km    : ₹{rate}")
        print(f"Surge Applied  : {'Yes' if surge else 'No'}")
        print(f"Final Fare     : ₹{final_price:.2f}")
        break
    
    #handle invalid inputs(non numeric inputs)
    except ValueError:
        print("Invalid output . Please enter correct values")

