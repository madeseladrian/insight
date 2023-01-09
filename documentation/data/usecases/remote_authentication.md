# Remote Authentication Use Case

> ## Caso de sucesso (OK - 200)
1. ✅ Sistema faz uma requisição para a URL da API de login
2. ✅ Sistema faz uma requisição para o método correto
3. ✅ Sistema valida os dados recebidos
4. ✅ Sistema entrega os dados da conta do usuário

> ## Exceção - Dados inválidos (Bad Request - 400)
5. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Credenciais inválidas (Unauthorized - 401)
6. ✅ Sistema retorna uma mensagem de erro informando que as credenciais estão erradas

> ## Exceção - URL inválida (Not Found - 404)
7. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Falha no servidor (Internal Server Error - 500)
8. ✅ Sistema retorna uma mensagem de erro inesperado

> ## Exceção - Resposta inválida (OK - 200)
9. ❌ Sistema retorna uma mensagem de erro inesperado