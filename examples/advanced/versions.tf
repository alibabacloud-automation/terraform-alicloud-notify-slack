# Copyright 2024 Alibaba Cloud. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0

terraform {
  required_version = ">= 1.3"

  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.188.0"
    }
  }
}
