#pragma once

#include "queue.h"

#include <libwebsockets.h>

struct per_session_data__bulletin_board_protocol
{
    char *client_name;
    void *data;
    size_t data_length;

    struct queue_node *messages_queue;
    struct queue_node *data_queue;
};

void init_bulletin_board_protocol(void);
void deinit_bulletin_board_protocol(void);

int callback_bulletin_board(
        struct lws *wsi, enum lws_callback_reasons reason, void *user, void *in, size_t len);

