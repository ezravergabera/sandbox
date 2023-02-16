#include <stdio.h>
#include <stdlib.h>

struct Node {
    int data;
    struct Node* left;
    struct Node* right;
};

struct Node* newNode(int data) {
    struct Node* node = (struct Node*) malloc(sizeof(struct Node));
    node->data = data;
    node->left = NULL;
    node->right = NULL;

    return node;
}

struct Node* insert(struct Node* node, int data) {
    if (node == NULL)
        return newNode(data);
    if (data < node->data)
        node->left = insert(node->left, data);
    else if (data > node->data)
        node->right = insert(node->right, data);
    return node;
}

void inOrder(struct Node* root) {
    if (root == NULL)
        return;
    inOrder(root->left);
    printf("%d ", root->data);
    inOrder(root->right);
}

void preOrder (struct Node* root) {
  if (root == NULL)
    return;
  printf("%d ", root->data);
  preOrder(root->left);
  preOrder(root->right);
}

void postOrder (struct Node* root) {
  if (root == NULL)
    return;
  preOrder(root->left);
  preOrder(root->right);
  printf("%d ", root->data);
}

int main() {
    struct Node* root = NULL;
    root = insert(root, 50);
    insert(root, 30);
    insert(root, 20);
    insert(root, 40);
    insert(root, 70);
    insert(root, 60);
    insert(root, 80);
    
    inOrder(root);
    printf("\n");
    preOrder(root);
    printf("\n");
    postOrder(root);

    return 0;
}