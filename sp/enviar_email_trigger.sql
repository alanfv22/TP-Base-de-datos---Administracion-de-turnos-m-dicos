CREATE TRIGGER enviar_email_trigger
AFTER UPDATE ON turno
FOR EACH ROW
EXECUTE FUNCTION enviar_email();