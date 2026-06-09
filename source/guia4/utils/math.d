module guia4.utils.math;

/// 将 val 限制在 [min, max] 范围内
int clamp(int val, int min, int max) nothrow @nogc pure
{
    if (val < min) return min;
    if (val > max) return max;
    return val;
}