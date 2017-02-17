function done = clamp(value, low, high)
done = min(high, max(low, value));
end