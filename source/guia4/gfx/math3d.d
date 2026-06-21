module guia4.gfx.math3d;

import std.math;
import std.algorithm;

/// Immutable 3D vector
struct Vec3
{
    float x, y, z;

    static Vec3 opCall(float x, float y, float z)
    {
        Vec3 v;
        v.x = x; v.y = y; v.z = z;
        return v;
    }

    Vec3 opBinary(string op)(Vec3 rhs) const
    {
        static if (op == "+")  return Vec3(x + rhs.x, y + rhs.y, z + rhs.z);
        static if (op == "-")  return Vec3(x - rhs.x, y - rhs.y, z - rhs.z);
        static if (op == "*")  return Vec3(x * rhs.x, y * rhs.y, z * rhs.z);
        static if (op == "/")  return Vec3(x / rhs.x, y / rhs.y, z / rhs.z);
    }

    Vec3 opBinary(string op)(float s) const
    {
        static if (op == "*")  return Vec3(x * s, y * s, z * s);
        static if (op == "/")  return Vec3(x / s, y / s, z / s);
    }

    Vec3 opUnary(string op)() const
        if (op == "-")
    {
        return Vec3(-x, -y, -z);
    }

    float dot(Vec3 rhs) const
    {
        return x * rhs.x + y * rhs.y + z * rhs.z;
    }

    Vec3 cross(Vec3 rhs) const
    {
        return Vec3(
            y * rhs.z - z * rhs.y,
            z * rhs.x - x * rhs.z,
            x * rhs.y - y * rhs.x
        );
    }

    float length() const
    {
        return sqrt(x * x + y * y + z * z);
    }

    Vec3 normalized() const
    {
        float len = length();
        if (len < 1e-8f) return Vec3(0, 0, 0);
        return Vec3(x / len, y / len, z / len);
    }

    /// Apply a 4x4 matrix transform (treats as position, w=1)
    Vec3 transform(Mat4 m) const
    {
        float w = m.data[3] * x + m.data[7] * y + m.data[11] * z + m.data[15];
        if (abs(w) < 1e-10f) w = 1e-10f;
        return Vec3(
            (m.data[0] * x + m.data[4] * y + m.data[8]  * z + m.data[12]) / w,
            (m.data[1] * x + m.data[5] * y + m.data[9]  * z + m.data[13]) / w,
            (m.data[2] * x + m.data[6] * y + m.data[10] * z + m.data[14]) / w
        );
    }
}

/// 4x4 column-major matrix
struct Mat4
{
    /// 16 floats, column-major: data[col*4 + row]
    float[16] data;

    static Mat4 identity()
    {
        Mat4 m;
        m.data[0]  = 1; m.data[5]  = 1;
        m.data[10] = 1; m.data[15] = 1;
        return m;
    }

    /// Perspective projection matrix
    static Mat4 perspective(float fovDeg, float aspect, float near, float far)
    {
        float f = 1.0f / tan(fovDeg * PI / 360.0f);
        float range = near - far;

        Mat4 m;
        m.data[0]  = f / aspect;
        m.data[5]  = f;
        m.data[10] = (far + near) / range;
        m.data[11] = -1;
        m.data[14] = 2 * far * near / range;
        m.data[15] = 0;
        return m;
    }

    /// LookAt view matrix
    static Mat4 lookAt(Vec3 eye, Vec3 target, Vec3 up)
    {
        Vec3 fwd = (target - eye).normalized();
        Vec3 right = fwd.cross(up).normalized();
        Vec3 newUp = right.cross(fwd);

        Mat4 m = identity();
        m.data[0]  = right.x;
        m.data[1]  = newUp.x;
        m.data[2]  = -fwd.x;
        m.data[4]  = right.y;
        m.data[5]  = newUp.y;
        m.data[6]  = -fwd.y;
        m.data[8]  = right.z;
        m.data[9]  = newUp.z;
        m.data[10] = -fwd.z;
        m.data[12] = -right.dot(eye);
        m.data[13] = -newUp.dot(eye);
        m.data[14] = fwd.dot(eye);
        return m;
    }

    /// Rotation around X axis (degrees)
    static Mat4 rotateX(float deg)
    {
        float rad = deg * PI / 180.0f;
        float c = cos(rad), s = sin(rad);
        Mat4 m = identity();
        m.data[5]  = c;   m.data[6]  = s;
        m.data[9]  = -s;  m.data[10] = c;
        return m;
    }

    /// Rotation around Y axis (degrees)
    static Mat4 rotateY(float deg)
    {
        float rad = deg * PI / 180.0f;
        float c = cos(rad), s = sin(rad);
        Mat4 m = identity();
        m.data[0]  = c;  m.data[2]  = -s;
        m.data[8]  = s;  m.data[10] = c;
        return m;
    }

    /// Rotation around Z axis (degrees)
    static Mat4 rotateZ(float deg)
    {
        float rad = deg * PI / 180.0f;
        float c = cos(rad), s = sin(rad);
        Mat4 m = identity();
        m.data[0]  = c;  m.data[1]  = s;
        m.data[4]  = -s; m.data[5]  = c;
        return m;
    }

    /// Translation matrix
    static Mat4 translate(float tx, float ty, float tz)
    {
        Mat4 m = identity();
        m.data[12] = tx;
        m.data[13] = ty;
        m.data[14] = tz;
        return m;
    }

    /// Scale matrix
    static Mat4 scale(float sx, float sy, float sz)
    {
        Mat4 m = identity();
        m.data[0] = sx;
        m.data[5] = sy;
        m.data[10] = sz;
        return m;
    }

    /// Matrix multiplication (this * rhs)
    Mat4 opBinary(string op)(Mat4 rhs) const
        if (op == "*")
    {
        Mat4 r;
        for (int col = 0; col < 4; col++)
        {
            for (int row = 0; row < 4; row++)
            {
                float sum = 0;
                for (int k = 0; k < 4; k++)
                    sum += data[k * 4 + row] * rhs.data[col * 4 + k];
                r.data[col * 4 + row] = sum;
            }
        }
        return r;
    }

    /// Matrix * Vec3 (treats as position, w=1)
    Vec3 opBinary(string op)(Vec3 v) const
        if (op == "*")
    {
        return v.transform(this);
    }

    /// Transform a Vec3 (treats as direction, w=0 — no translation)
    Vec3 transformDir(Vec3 v) const
    {
        return Vec3(
            data[0] * v.x + data[4] * v.y + data[8]  * v.z,
            data[1] * v.x + data[5] * v.y + data[9]  * v.z,
            data[2] * v.x + data[6] * v.y + data[10] * v.z
        );
    }

    /// Apply matrix to Vec3 as a position (w=1)
    Vec3 transformPoint(Vec3 v) const
    {
        return v.transform(this);
    }
}
