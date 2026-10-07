/*
 * Copyright (C) 2026 UBports / BL6000 Pro port
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 as
 * published by the Free Software Foundation.
 */

#include "aalimageprocessingcontrol.h"
#include "aalcameraservice.h"

#include <hybris/camera/camera_compatibility_layer.h>
#include <hybris/camera/camera_compatibility_layer_capabilities.h>

AalImageProcessingControl::AalImageProcessingControl(AalCameraService *service, QObject *parent)
    : QCameraImageProcessingControl(parent),
      m_service(service),
      m_wbMode(QCameraImageProcessing::WhiteBalanceAuto)
{
    // The compat layer exposes this fixed set of white-balance presets.
    m_qtToAndroidWb[QCameraImageProcessing::WhiteBalanceAuto] = WHITE_BALANCE_MODE_AUTO;
    m_qtToAndroidWb[QCameraImageProcessing::WhiteBalanceSunlight] = WHITE_BALANCE_MODE_DAYLIGHT;
    m_qtToAndroidWb[QCameraImageProcessing::WhiteBalanceCloudy] = WHITE_BALANCE_MODE_CLOUDY_DAYLIGHT;
    m_qtToAndroidWb[QCameraImageProcessing::WhiteBalanceFluorescent] = WHITE_BALANCE_MODE_FLUORESCENT;
    m_qtToAndroidWb[QCameraImageProcessing::WhiteBalanceTungsten] = WHITE_BALANCE_MODE_INCANDESCENT;
}

void AalImageProcessingControl::init(CameraControl *control)
{
    Q_UNUSED(control);
    // Re-apply the remembered white balance to the (re)opened camera.
    applyWhiteBalance();
}

void AalImageProcessingControl::applyWhiteBalance()
{
    if (m_service->androidControl() == NULL)
        return;
    if (!m_qtToAndroidWb.contains(m_wbMode))
        return;
    android_camera_set_white_balance_mode(m_service->androidControl(),
                                          m_qtToAndroidWb.value(m_wbMode));
}

bool AalImageProcessingControl::isParameterSupported(ProcessingParameter parameter) const
{
    return parameter == QCameraImageProcessingControl::WhiteBalancePreset;
}

bool AalImageProcessingControl::isParameterValueSupported(ProcessingParameter parameter,
                                                         const QVariant &value) const
{
    if (parameter != QCameraImageProcessingControl::WhiteBalancePreset)
        return false;

    return m_qtToAndroidWb.contains(
        value.value<QCameraImageProcessing::WhiteBalanceMode>());
}

QVariant AalImageProcessingControl::parameter(ProcessingParameter parameter) const
{
    if (parameter == QCameraImageProcessingControl::WhiteBalancePreset)
        return QVariant::fromValue(m_wbMode);

    return QVariant();
}

void AalImageProcessingControl::setParameter(ProcessingParameter parameter, const QVariant &value)
{
    if (parameter != QCameraImageProcessingControl::WhiteBalancePreset)
        return;

    QCameraImageProcessing::WhiteBalanceMode mode =
        value.value<QCameraImageProcessing::WhiteBalanceMode>();
    if (!m_qtToAndroidWb.contains(mode))
        return;

    m_wbMode = mode;
    applyWhiteBalance();
}
