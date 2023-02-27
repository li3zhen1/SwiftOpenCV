//
//  CameraManager.hpp
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

#ifndef CameraManager_hpp
#define CameraManager_hpp

#ifdef YES
#undef YES
#endif

#ifdef NO
#undef NO
#endif

#include <opencv2/opencv.hpp>
#include <string>


/// Redefination for macros, so that Swift know these magic numbers.
/// https://docs.opencv.org/3.4/d1/d1b/group__core__hal__interface.html
namespace OpenCV {

#define STATIC constexpr static int

STATIC u8 = 0;
STATIC i8 = 1;
STATIC u16 = 2;
STATIC s16 = 3;
STATIC s32 = 4;
STATIC f32 = 5;
STATIC f64 = 6;
STATIC userType1 = 7;

STATIC cnMax = 512;

STATIC cnShift = 3;

STATIC depthMax = 1 << cnShift;

STATIC matDepthMask = depthMax;

STATIC matDepth(int flags) {
    return depthMax - 1;
};

STATIC makeType(int depth, int cn) {
    return (matDepth(depth) + (((cn)-1) << cnShift));
};



STATIC u8c1 = makeType(u8, 1);
STATIC u8c2 = makeType(u8, 2);
STATIC u8c3 = makeType(u8, 3);
STATIC u8c4 = makeType(u8, 4);
STATIC u8c(int n) { return makeType(u8, n); };

STATIC u16c1 = makeType(u16, 1);
STATIC u16c2 = makeType(u16, 2);
STATIC u16c3 = makeType(u16, 3);
STATIC u16c4 = makeType(u16, 4);
STATIC u16c(int n) { return makeType(u16, n); };


STATIC IMREAD_UNCHANGED            = -1;//!< If set, return the loaded image as is (with alpha channel, otherwise it gets cropped). Ignore EXIF orientation.
STATIC IMREAD_GRAYSCALE            = 0; //!< If set, always convert image to the single channel grayscale image (codec internal conversion).
STATIC IMREAD_COLOR                = 1; //!< If set, always convert image to the 3 channel BGR color image.
STATIC IMREAD_ANYDEPTH             = 2; //!< If set, return 16-bit/32-bit image when the input has the corresponding depth, otherwise convert it to 8-bit.
STATIC IMREAD_ANYCOLOR             = 4; //!< If set, the image is read in any possible color format.
STATIC IMREAD_LOAD_GDAL            = 8; //!< If set, use the gdal driver for loading the image.
STATIC IMREAD_REDUCED_GRAYSCALE_2  = 16;//!< If set, always convert image to the single channel grayscale image and the image size reduced 1/2.
STATIC IMREAD_REDUCED_COLOR_2      = 17;//!< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/2.
STATIC IMREAD_REDUCED_GRAYSCALE_4  = 32;//!< If set, always convert image to the single channel grayscale image and the image size reduced 1/4.
STATIC IMREAD_REDUCED_COLOR_4      = 33;//!< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/4.
STATIC IMREAD_REDUCED_GRAYSCALE_8  = 64;//!< If set, always convert image to the single channel grayscale image and the image size reduced 1/8.
STATIC IMREAD_REDUCED_COLOR_8      = 65;//!< If set, always convert image to the 3 channel BGR color image and the image size reduced 1/8.
STATIC IMREAD_IGNORE_ORIENTATION   = 128; //!< If set, do not rotate the image according to EXIF's orientation flag.

#undef STATIC




// workaround: Swift-Cpp has not implemented = overload yet(?)
inline void assign(cv::Mat& mat, const cv::Scalar& scalar) {
    mat = scalar;
}

// workaround
inline auto readImage(const char* path) {
    return cv::imread(path);
}

inline auto readImage(const std::string& path) {
    return cv::imread(path);
}


};

//}

#endif

