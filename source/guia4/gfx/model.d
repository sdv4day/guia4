module guia4.gfx.model;

import guia4.gfx.math3d;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.exception;

/**
 * Triangle face — indices into vertex/normal/texcoord arrays.
 * All indices are 0-based after conversion from OBJ's 1-based format.
 */
struct Face
{
    int[3] verts;    /// vertex position indices
    int[3] normals;  /// vertex normal indices (-1 = none)
    int[3] texcoords;/// texture coordinate indices (-1 = none)
}

/**
 * 3D mesh loaded from an OBJ file.
 */
struct Model
{
    Vec3[] vertices;
    Vec3[] normals;
    Vec2[] texcoords;
    Face[] faces;

    /// Compute face normals if none were provided in the OBJ
    void computeFaceNormals()
    {
        if (faces.length == 0) return;

        foreach (ref f; faces)
        {
            if (f.normals[0] >= 0) continue; // already has normals

            Vec3 v0 = vertices[f.verts[0]];
            Vec3 v1 = vertices[f.verts[1]];
            Vec3 v2 = vertices[f.verts[2]];

            Vec3 edge1 = v1 - v0;
            Vec3 edge2 = v2 - v0;
            Vec3 n = edge1.cross(edge2).normalized();

            // push computed normal
            int idx = cast(int)normals.length;
            normals ~= n;
            f.normals[0] = idx;
            f.normals[1] = idx;
            f.normals[2] = idx;
        }
    }

    /// Compute bounding sphere center and radius
    void boundingSphere(out Vec3 center, out float radius) const
    {
        if (vertices.length == 0)
        {
            center = Vec3(0, 0, 0);
            radius = 1;
            return;
        }

        // average center
        center = Vec3(0, 0, 0);
        foreach (v; vertices)
            center = center + v;
        center = center * (1.0f / vertices.length);

        radius = 0;
        foreach (v; vertices)
        {
            float d = (v - center).length();
            if (d > radius) radius = d;
        }
    }

    /// Center model at origin and scale to fit in [-1, 1]
    void normalize()
    {
        if (vertices.length == 0) return;

        Vec3 center;
        float r;
        boundingSphere(center, r);
        if (r < 1e-8f) r = 1;

        float scale = 1.0f / r;
        foreach (ref v; vertices)
        {
            v = (v - center) * scale;
        }

        // also adjust normals if present
        // (normals shouldn't need centering, but if we had them they stay)
    }
}

/// Simple OBJ parser
Model loadOBJ(string filename)
{
    import std.file : readText;

    string content = readText(filename);
    return parseOBJ(content);
}

/// Parse OBJ format from a string
Model parseOBJ(string content)
{
    Model m;

    foreach (line; content.splitLines())
    {
        string trimmed = line.strip();
        if (trimmed.length == 0 || trimmed[0] == '#')
            continue;

        auto parts = trimmed.split();
        if (parts.length == 0) continue;

        string cmd = parts[0];

        if (cmd == "v" && parts.length >= 4)
        {
            float x = parse!float(parts[1]);
            float y = parse!float(parts[2]);
            float z = parse!float(parts[3]);
            m.vertices ~= Vec3(x, y, z);
        }
        else if (cmd == "vt" && parts.length >= 3)
        {
            float u = parse!float(parts[1]);
            float v = parse!float(parts[2]);
            m.texcoords ~= Vec2(u, v);
        }
        else if (cmd == "vn" && parts.length >= 4)
        {
            float x = parse!float(parts[1]);
            float y = parse!float(parts[2]);
            float z = parse!float(parts[3]);
            m.normals ~= Vec3(x, y, z);
        }
        else if (cmd == "f" && parts.length >= 4)
        {
            Face f;
            f.normals[] = -1;
            f.texcoords[] = -1;

            for (int i = 0; i < 3 && i + 1 < parts.length; i++)
            {
                auto vParts = parts[i + 1].split('/');
                f.verts[i] = parseIndex(vParts[0]);

                if (vParts.length >= 2 && vParts[1].length > 0)
                    f.texcoords[i] = parseIndex(vParts[1]);

                if (vParts.length >= 3 && vParts[2].length > 0)
                    f.normals[i] = parseIndex(vParts[2]);
            }

            // handle quad -> two triangles
            if (parts.length >= 5)
            {
                // second triangle: (v1, v3, v4)
                Face f2;
                f2.normals[] = -1;
                f2.texcoords[] = -1;

                auto vParts1 = parts[1].split('/');
                auto vParts3 = parts[3].split('/');
                auto vParts4 = parts[4].split('/');

                f2.verts[0] = parseIndex(vParts1[0]);
                f2.verts[1] = parseIndex(vParts3[0]);
                f2.verts[2] = parseIndex(vParts4[0]);

                if (vParts1.length >= 2 && vParts1[1].length > 0)
                    f2.texcoords[0] = parseIndex(vParts1[1]);
                if (vParts3.length >= 2 && vParts3[1].length > 0)
                    f2.texcoords[1] = parseIndex(vParts3[1]);
                if (vParts4.length >= 2 && vParts4[1].length > 0)
                    f2.texcoords[2] = parseIndex(vParts4[1]);

                if (vParts1.length >= 3 && vParts1[2].length > 0)
                    f2.normals[0] = parseIndex(vParts1[2]);
                if (vParts3.length >= 3 && vParts3[2].length > 0)
                    f2.normals[1] = parseIndex(vParts3[2]);
                if (vParts4.length >= 3 && vParts4[2].length > 0)
                    f2.normals[2] = parseIndex(vParts4[2]);

                m.faces ~= f2;
            }

            m.faces ~= f;
        }
    }

    return m;
}

/// OBJ indices are 1-based; convert to 0-based
int parseIndex(string s)
{
    int idx = parse!int(s);
    return idx - 1; // OBJ is 1-based
}

/// 2D texture coordinate
struct Vec2
{
    float u, v;
}
