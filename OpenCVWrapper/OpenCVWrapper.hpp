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

//cv::_InputArray::~_InputArray() {
//    
//}

void captureOneFrame();


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


STATIC CAP_PROP_POS_MSEC       =0; //!< Current position of the video file in milliseconds.
STATIC CAP_PROP_POS_FRAMES     =1; //!< 0-based index of the frame to be decoded/captured next.
STATIC CAP_PROP_POS_AVI_RATIO  =2; //!< Relative position of the video file: 0=start of the film, 1=end of the film.
STATIC CAP_PROP_FRAME_WIDTH    =3; //!< Width of the frames in the video stream.
STATIC CAP_PROP_FRAME_HEIGHT   =4; //!< Height of the frames in the video stream.
STATIC CAP_PROP_FPS            =5; //!< Frame rate.
STATIC CAP_PROP_FOURCC         =6; //!< 4-character code of codec. see VideoWriter::fourcc .
STATIC CAP_PROP_FRAME_COUNT    =7; //!< Number of frames in the video file.
STATIC CAP_PROP_FORMAT         =8; //!< Format of the %Mat objects (see Mat::type()) returned by VideoCapture::retrieve().
                            //!< Set value -1 to fetch undecoded RAW video streams (as Mat 8UC1).
STATIC CAP_PROP_MODE           =9; //!< Backend-specific value indicating the current capture mode.
STATIC CAP_PROP_BRIGHTNESS    =10; //!< Brightness of the image (only for those cameras that support).
STATIC CAP_PROP_CONTRAST      =11; //!< Contrast of the image (only for cameras).
STATIC CAP_PROP_SATURATION    =12; //!< Saturation of the image (only for cameras).
STATIC CAP_PROP_HUE           =13; //!< Hue of the image (only for cameras).
STATIC CAP_PROP_GAIN          =14; //!< Gain of the image (only for those cameras that support).
STATIC CAP_PROP_EXPOSURE      =15; //!< Exposure (only for those cameras that support).
STATIC CAP_PROP_CONVERT_RGB   =16; //!< Boolean flags indicating whether images should be converted to RGB. <br/>
                            //!< *GStreamer note*: The flag is ignored in case if custom pipeline is used. It's user responsibility to interpret pipeline output.
STATIC CAP_PROP_WHITE_BALANCE_BLUE_U =17; //!< Currently unsupported.
STATIC CAP_PROP_RECTIFICATION =18; //!< Rectification flag for stereo cameras (note: only supported by DC1394 v 2.x backend currently).
STATIC CAP_PROP_MONOCHROME    =19;
STATIC CAP_PROP_SHARPNESS     =20;
STATIC CAP_PROP_AUTO_EXPOSURE =21; //!< DC1394: exposure control done by camera, user can adjust reference level using this feature.
STATIC CAP_PROP_GAMMA         =22;
STATIC CAP_PROP_TEMPERATURE   =23;
STATIC CAP_PROP_TRIGGER       =24;
STATIC CAP_PROP_TRIGGER_DELAY =25;
STATIC CAP_PROP_WHITE_BALANCE_RED_V =26;
STATIC CAP_PROP_ZOOM          =27;
STATIC CAP_PROP_FOCUS         =28;
STATIC CAP_PROP_GUID          =29;
STATIC CAP_PROP_ISO_SPEED     =30;
STATIC CAP_PROP_BACKLIGHT     =32;
STATIC CAP_PROP_PAN           =33;
STATIC CAP_PROP_TILT          =34;
STATIC CAP_PROP_ROLL          =35;
STATIC CAP_PROP_IRIS          =36;
STATIC CAP_PROP_SETTINGS      =37; //!< Pop up video/camera filter dialog (note: only supported by DSHOW backend currently. The property value is ignored)
STATIC CAP_PROP_BUFFERSIZE    =38;
STATIC CAP_PROP_AUTOFOCUS     =39;
STATIC CAP_PROP_SAR_NUM       =40; //!< Sample aspect ratio: num/den (num)
STATIC CAP_PROP_SAR_DEN       =41; //!< Sample aspect ratio: num/den (den)
STATIC CAP_PROP_BACKEND       =42; //!< Current backend (enum VideoCaptureAPIs). Read-only property
STATIC CAP_PROP_CHANNEL       =43; //!< Video input or Channel Number (only for those cameras that support)
STATIC CAP_PROP_AUTO_WB       =44; //!< enable/ disable auto white-balance
STATIC CAP_PROP_WB_TEMPERATURE=45; //!< white-balance color temperature
STATIC CAP_PROP_CODEC_PIXEL_FORMAT =46;    //!< (read-only) codec's pixel format. 4-character code - see VideoWriter::fourcc . Subset of [AV_PIX_FMT_*](https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/raw.c) or -1 if unknown
STATIC CAP_PROP_BITRATE       =47; //!< (read-only) Video bitrate in kbits/s
STATIC CAP_PROP_ORIENTATION_META=48; //!< (read-only) Frame rotation defined by stream meta (applicable for FFmpeg and AVFoundation back-ends only)
STATIC CAP_PROP_ORIENTATION_AUTO=49; //!< if true - rotates output frames of CvCapture considering video file's metadata  (applicable for FFmpeg and AVFoundation back-ends only) (https://github.com/opencv/opencv/issues/15499)
STATIC CAP_PROP_HW_ACCELERATION=50; //!< (**open-only**) Hardware acceleration type (see #VideoAccelerationType). Setting supported only via `params` parameter in cv::VideoCapture constructor / .open() method. Default value is backend-specific.
STATIC CAP_PROP_HW_DEVICE      =51; //!< (**open-only**) Hardware device index (select GPU if multiple available). Device enumeration is acceleration type specific.
STATIC CAP_PROP_HW_ACCELERATION_USE_OPENCL=52; //!< (**open-only**) If non-zero, create new OpenCL context and bind it to current thread. The OpenCL context created with Video Acceleration context attached it (if not attached yet) for optimized GPU data copy between HW accelerated decoder and cv::UMat.
STATIC CAP_PROP_OPEN_TIMEOUT_MSEC=53; //!< (**open-only**) timeout in milliseconds for opening a video capture (applicable for FFmpeg and GStreamer back-ends only)
STATIC CAP_PROP_READ_TIMEOUT_MSEC=54; //!< (**open-only**) timeout in milliseconds for reading from a video capture (applicable for FFmpeg and GStreamer back-ends only)
STATIC CAP_PROP_STREAM_OPEN_TIME_USEC =55; //<! (read-only) time in microseconds since Jan 1 1970 when stream was opened. Applicable for FFmpeg backend only. Useful for RTSP and other live streams
STATIC CAP_PROP_VIDEO_TOTAL_CHANNELS = 56; //!< (read-only) Number of video channels
STATIC CAP_PROP_VIDEO_STREAM = 57; //!< (**open-only**) Specify video stream, 0-based index. Use -1 to disable video stream from file or IP cameras. Default value is 0.
STATIC CAP_PROP_AUDIO_STREAM = 58; //!< (**open-only**) Specify stream in multi-language media files, -1 - disable audio processing or microphone. Default value is -1.
STATIC CAP_PROP_AUDIO_POS = 59; //!< (read-only) Audio position is measured in samples. Accurate audio sample timestamp of previous grabbed fragment. See CAP_PROP_AUDIO_SAMPLES_PER_SECOND and CAP_PROP_AUDIO_SHIFT_NSEC.
STATIC CAP_PROP_AUDIO_SHIFT_NSEC = 60; //!< (read only) Contains the time difference between the start of the audio stream and the video stream in nanoseconds. Positive value means that audio is started after the first video frame. Negative value means that audio is started before the first video frame.
STATIC CAP_PROP_AUDIO_DATA_DEPTH = 61; //!< (open, read) Alternative definition to bits-per-sample, but with clear handling of 32F / 32S
STATIC CAP_PROP_AUDIO_SAMPLES_PER_SECOND = 62; //!< (open, read) determined from file/codec input. If not specified, then selected audio sample rate is 44100
STATIC CAP_PROP_AUDIO_BASE_INDEX = 63; //!< (read-only) Index of the first audio channel for .retrieve() calls. That audio channel number continues enumeration after video channels.
STATIC CAP_PROP_AUDIO_TOTAL_CHANNELS = 64; //!< (read-only) Number of audio channels in the selected audio stream (mono, stereo, etc)
STATIC CAP_PROP_AUDIO_TOTAL_STREAMS = 65; //!< (read-only) Number of audio streams.
STATIC CAP_PROP_AUDIO_SYNCHRONIZE = 66; //!< (open, read) Enables audio synchronization.
STATIC CAP_PROP_LRF_HAS_KEY_FRAME = 67; //!< FFmpeg back-end only - Indicates whether the Last Raw Frame (LRF), output from VideoCapture::read() when VideoCapture is initialized with VideoCapture::open(CAP_FFMPEG, {CAP_PROP_FORMAT, -1}) or VideoCapture::set(CAP_PROP_FORMAT,-1) is called before the first call to VideoCapture::read(), contains encoded data for a key frame.
STATIC CAP_PROP_CODEC_EXTRADATA_INDEX = 68; //!< Positive index indicates that returning extra data is supported by the video back end.  This can be retrieved as cap.retrieve(data, <returned index>).  E.g. When reading from a h264 encoded RTSP stream, the FFmpeg backend could return the SPS and/or PPS if available (if sent in reply to a DESCRIBE request), from calls to cap.retrieve(data, <returned index>).
STATIC CAP_PROP_FRAME_TYPE = 69; //!< (read-only) FFmpeg back-end only - Frame type ascii code (73 = 'I', 80 = 'P', 66 = 'B' or 63 = '?' if unknown) of the most recently read frame.
STATIC CAP_PROP_N_THREADS = 70;

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
//
inline auto showImage(const char* windowName, const cv::Mat& mat) {
    return cv::imshow(windowName, mat);
}

inline auto showImage(const std::string& windowName, const cv::Mat& mat) {
    return cv::imshow(windowName, mat);
}

inline cv::String cvString(const char* str) {
    return str;
}

bool readFrame(cv::VideoCapture& vc, cv::Mat &mat);

inline bool captureFrame(cv::VideoCapture& vc, cv::Mat &mat) {
    return vc.read(mat);
}

inline cv::Mat reverseChannels(const cv::Mat &mat) {
    using namespace cv;
    Mat Bands[3], merged;
    split(mat, Bands);
    Mat channels[3] = {Bands[2], Bands[1], Bands[0]};
    merge(channels, 3, merged);
    return merged;
}

inline cv::VideoCapture VideoCapture(const char* path) {
    return cv::VideoCapture(path);
}

inline void putText(cv::Mat& mat, const char* text) {
    auto p = cv::Point(100, 200);
    cv::putText(mat, text, p, 0, 2.0, cv::Scalar(0xffffff));
}

};


#endif

