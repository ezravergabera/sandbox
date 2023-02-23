#include <stdio.h>
#include <stdlib.h>

struct node {
    int data;
    struct node *next;
} *head, *current, *tail, *before;

void insert_first(int element) {
    current = (struct node*)malloc(sizeof(struct node));
    current->data = element;

    if (head == NULL) {
        current->next = NULL;
        tail = current;
    } else {
        current->next = head;
    }
    head = current;
}

void insert_end(int element) {
    current = (struct node*)malloc(sizeof(struct node));
    current->data = element;
    current->next = NULL;

    if (head == NULL) {
        head = current;
    } else {
        tail->next = current;
    }
    tail = current;
}

int delete_first() {
    if (head == NULL) {
        return 0;
    }
    if (head == tail) {
        int temp = tail->data;
        head = NULL;
        tail = NULL;
        return temp;
    } else {
        current = head;
        int temp = current->data;
        head = current->next;
        return temp;
    }
}

int delete_last() {
    if (head == NULL) {
        return 0;
    }
    if (head == tail) {
        int temp = tail->data;
        head = NULL;
        tail = NULL;
        return temp;
    } else {
        int temp = tail->data;
        current = head;
        while (current->next != NULL) {
            before = current;
            current = current->next;
        }
        before->next = NULL;
        tail = before;
        return temp;
    }
}

void display () {
    current = head;

    while (current != NULL) {
        printf("%d ", current->data);
        current = current->next;
    }
}

int main() {
    int temp = delete_last();
    printf("%d\n", temp);
    temp = delete_first();
    printf("%d\n", temp);
    insert_end(10);
    insert_first(10);
    insert_end(30);
    insert_first(100);
    insert_first(20);
    temp = delete_last();
    printf("%d", temp);
    insert_end(500);
    temp = delete_last();
    printf("%d", temp);
    insert_end(500);
    insert_end(300);
    insert_first(25);
    temp = delete_last();
    printf("%d", temp);
    display();
}