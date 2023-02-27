//
//  OpenCVWrapper.cpp
//  SwiftOpenCV
//
//  Created by 李臻 on 2/27/23.
//

#include "OpenCVWrapper.hpp"

void captureOneFrame(){
    auto cap = cv::VideoCapture(1);
    auto mat = cv::Mat();
    
    auto result = cap.read(mat);
    std::cout << result << std::endl;
    if(result) {
        cv::imshow("test", mat);
    }
}

bool OpenCV::readFrame(cv::VideoCapture& vc, cv::Mat &mat) {
    return vc.read(mat);
}


