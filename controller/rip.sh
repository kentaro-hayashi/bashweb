#!/bin/bash

rip_show() {
  response 200
}

rip_create() {
  NAME=${REQUEST_name}
  MEMO=${REQUEST_memo}
  response
}
