import numpy as np

def hex_to_signed_fraction(hex_value):
    num_bits = 4*(len(hex_value))
    binary_value = f"{int(hex_value, 16):0{num_bits}b}"
    
    sign_bit = int(binary_value[0])
    
    fractional_bits = binary_value[1:]
    fractional_value = int(fractional_bits, 2) / (2**(num_bits-1))  # Convert to float
    
    if sign_bit == 1:  
        return -fractional_value
    else:  
        return fractional_value

def calculate_ln_x_plus_1(X, N):
    consts = [0.99999999, -(1/2), 1/3, -(1/4), 1/5, -(1/6), 1/7, -(1/8)]
    power = 1
    exp = 1
    sum = 0
    for i in range(N+1):
        power *= X
        exp = power * consts[i]
        sum += exp
    return sum


def custom_float_representation(value):
    if value < -1.0 or value > 1.0:
        raise ValueError("Input must be between -1 and 1 (overflow).")
    
    abs_value = abs(value)
    
    scaled_value = int(abs_value * (2**31))
    
    if value >= 0:
        result = f"{0:1b}{scaled_value:031b}"  
    else:
        twos_complement = (1 << 31) - scaled_value  # 2's complement for 31 bits
        result = f"{1:1b}{twos_complement:031b}"  
    
    return result

def calculate_maclaren(X, N):
    float_x = hex_to_signed_fraction(X)
    # value = np.log(1 + float_x)  
    value = calculate_ln_x_plus_1(float_x, N)
    custom_representation = custom_float_representation(value)
    print(f"The input is 0x{X} ({float_x})")
    print(f"Custom 32-bit floating-point representation of {value} is:")
    print(f"{custom_representation}")
    print(f"{int(custom_representation, 2):08X}")


X = "06"                  # x in the range (-1, 1) in hex form
N = 7                     # N in the range [0, 7] in decimal form
calculate_maclaren(X, N)
