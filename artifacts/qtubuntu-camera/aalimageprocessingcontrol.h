/*
 * Copyright (C) 2026 UBports / BL6000 Pro port
 *
 * White balance control for the aal (Android abstraction layer) camera
 * backend. The libhybris camera compat layer already provides
 * android_camera_set_white_balance_mode / get_white_balance_mode; this
 * control exposes them to Qt as QCameraImageProcessing white-balance presets.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 as
 * published by the Free Software Foundation.
 */

#ifndef AALIMAGEPROCESSINGCONTROL_H
#define AALIMAGEPROCESSINGCONTROL_H

#include <QtCore/QMap>
#include <QCameraImageProcessingControl>
#include <hybris/camera/camera_compatibility_layer_capabilities.h>

class AalCameraService;
class CameraControl;

class AalImageProcessingControl : public QCameraImageProcessingControl
{
    Q_OBJECT
public:
    explicit AalImageProcessingControl(AalCameraService *service, QObject *parent = 0);

    void init(CameraControl *control);

    bool isParameterSupported(ProcessingParameter parameter) const;
    bool isParameterValueSupported(ProcessingParameter parameter,
                                   const QVariant &value) const;
    QVariant parameter(ProcessingParameter parameter) const;
    void setParameter(ProcessingParameter parameter, const QVariant &value);

private:
    void applyWhiteBalance();

    AalCameraService *m_service;
    QMap<QCameraImageProcessing::WhiteBalanceMode, WhiteBalanceMode> m_qtToAndroidWb;
    QCameraImageProcessing::WhiteBalanceMode m_wbMode;
};

#endif // AALIMAGEPROCESSINGCONTROL_H
