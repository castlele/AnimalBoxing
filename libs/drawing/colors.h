namespace castle {

struct Color {
    float red;
    float green;
    float blue;
    float alpha;

    Color(float r, float g, float b, float a)
        : red(r)
        , green(g)
        , blue(b)
        , alpha(a)
    {};

    static Color &Red() {
        static Color color = Color(1, 0, 0, 1);

        return color;
    }
    static Color &Green() {
        static Color color = Color(0, 1, 0, 1);

        return color;
    }
    static Color &Blue() {
        static Color color = Color(0, 0, 1, 1);

        return color;
    }
    static Color &White() {
        static Color color = Color(1, 1, 1, 1);

        return color;
    }

    static Color &Black() {
        static Color color = Color(0, 0, 0, 1);

        return color;
    }

    unsigned int redAsUInt();
    unsigned int greenAsUInt();
    unsigned int blueAsUInt();
    unsigned int alphaAsUInt();
};

}
